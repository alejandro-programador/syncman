import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/providers/payment_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/providers/bill_provider.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/widgets/notification.dart';
import 'package:syncman_new/widgets/success_message.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/repositories/bill/local_bill_read_repository.dart';
import 'package:syncman_new/repositories/bill/local_bill_write_repository.dart';
import 'package:syncman_new/services/sync/bill_service.dart' as sync;
import 'package:syncman_new/api/api_service.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/repositories/currency/local_currency_read_repository.dart';
import 'package:syncman_new/providers/bill_selection_provider.dart';
import 'package:syncman_new/providers/payment_method_provider.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/providers/selected_client_provider.dart';
import 'dart:async';
import 'package:syncman_new/screens/system/widgets/numbered_step.dart';
import 'package:syncman_new/screens/system/widgets/factura_step.dart';
import 'package:syncman_new/screens/system/widgets/metodo_de_pago_step.dart';
import 'package:syncman_new/screens/system/dialogs/collect_dialogs.dart';
import 'package:syncman_new/screens/system/services/currency_service.dart';
import 'package:syncman_new/screens/system/services/bill_service.dart';

class CollectReport extends StatefulWidget {
  const CollectReport({super.key});

  @override
  CollectReportState createState() => CollectReportState();
}

class CollectReportState extends State<CollectReport> {
  int _currentStep = 0;
  final int _maxSteps = 2;
  final PageController _pageController = PageController();
  
  late final BillProvider _billProvider;
  late final CurrencyService _currencyService;
  late final BillService _billService;
  List<String> _selectedFacturas = [];
  final TextEditingController _amountController = TextEditingController();
  String? _selectedTipo;
  final List<String> _tipos = ["Base", "IVA", "Base + IVA"];

  // Row field controllers
  final TextEditingController _titularCuentaController = TextEditingController();
  final TextEditingController _titularRifController = TextEditingController();
  final TextEditingController _referenciaController = TextEditingController();
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _cobroController = TextEditingController();
  final TextEditingController _baseController = TextEditingController();
  final TextEditingController _ivaController = TextEditingController();
  final TextEditingController _depositoController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _uuid = '';
  String? _depositoError;
  List<Map<String, dynamic>> _paymentMethods = [];
  bool _showSuccessMessage = false;
  Timer? _successMessageTimer;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _uuid = const Uuid().v4();
    _setupControllers();
  }

  void _initializeServices() {
    final database = AppDatabase.instance;
    final billReadRepository = LocalBillReadRepository(database.database);
    final billWriteRepository = LocalBillWriteRepository(database.database);
    final billService = sync.BillService(billReadRepository, billWriteRepository);
    _billProvider = BillProvider(billService);
    
    _currencyService = CurrencyService(LocalCurrencyReadRepository(database.database));
    _billService = BillService();
    
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _billService.loadClientId(context);
    await _currencyService.syncAndLoadCurrencies();
  }

  void _setupControllers() {
    _baseController.addListener(_updateDeposito);
    _ivaController.addListener(_updateDeposito);
    _cobroController.addListener(_validateDeposito);
  }

  void _updateDeposito() {
    if (_selectedTipo == "Base + IVA") {
      double baseValue = double.tryParse(_baseController.text) ?? 0;
      double ivaValue = double.tryParse(_ivaController.text) ?? 0;
      double depositValue = baseValue + ivaValue;
      _depositoController.text = depositValue.toStringAsFixed(2);
      _validateDeposito();
    }
  }

  void _validateDeposito() {
    if (_selectedTipo == "Base + IVA") {
      double depositValue = double.tryParse(_depositoController.text) ?? 0;
      double cobroValue = double.tryParse(_cobroController.text) ?? 0;
      bool hasError = depositValue != cobroValue;
      
      setState(() {
        if (hasError) {
          _depositoError = 'El depósito debe ser igual al cobro';
        } else {
          _depositoError = null;
        }
      });
    }
  }

  @override
  void dispose() {
    _billService.clearClientId();
    _baseController.removeListener(_updateDeposito);
    _ivaController.removeListener(_updateDeposito);
    _cobroController.removeListener(_validateDeposito);
    _successMessageTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Reporte de cobro", style: TextStyle(fontSize: 18)),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsView()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/notification.png',
                  width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              if (_showSuccessMessage)
                Container(
                  color: Colors.green[100],
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.add_card, color: Colors.green),
                        const SizedBox(width: 10),
                        Text('Método de pago agregado',
                            style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ),
              Container(
                color: AppTheme.greyBackground,
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _goToStep(0),
                      child: NumberedStep(
                        stepNumber: 1,
                        title: "Facturas",
                        stepIndex: 0,
                        currentStep: _currentStep,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.keyboard_arrow_right,
                        color: AppTheme.greyColor),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => _goToStep(1),
                      child: NumberedStep(
                        stepNumber: 2,
                        title: "Método de pago",
                        stepIndex: 1,
                        currentStep: _currentStep,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: AppTheme.greyBackground,
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      setState(() => _currentStep = index);
                    },
                    children: [
                      FacturaStep(
                        selectedFacturas: _selectedFacturas,
                        selectedTipo: _selectedTipo,
                        selectedCurrencyName: _currencyService.selectedCurrency?.nombre,
                        onFacturaTap: () => _showFacturaDropdown(context),
                        onTipoTap: () => _showTipoDropdown(context),
                        onCurrencyTap: () => _showCurrencyDropdown(context),
                      ),
                      MetodoDePagoStep(
                        paymentMethods: _paymentMethods,
                        showSuccessMessage: _showSuccessMessage,
                        titularCuentaController: _titularCuentaController,
                        titularRifController: _titularRifController,
                        referenciaController: _referenciaController,
                        fechaController: _fechaController,
                        cobroController: _cobroController,
                        baseController: _baseController,
                        ivaController: _ivaController,
                        depositoController: _depositoController,
                        amountController: _amountController,
                        descriptionController: _descriptionController,
                        selectedTipo: _selectedTipo,
                        depositoError: _depositoError,
                        onAddPaymentMethod: _addPaymentMethod,
                        onPaymentMethodTap: () => _showPaymentMethodDropdown(context),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppTheme.greyBackground,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () async {
                            if (_currentStep == 0) {
                              _goToStep(_currentStep + 1);
                            } else {
                              final payment = Payment.register(
                                id: _uuid,
                                metodosPago: Provider.of<PaymentMethodProvider>(context, listen: false).selectedPaymentMethod?.id ?? '',
                                tasa: _baseController.text,
                                tasaIva: _ivaController.text,
                                facturas: jsonEncode(_selectedFacturas),
                                cliente: '',
                                vendedor: '',
                                tipo: _selectedTipo ?? 'Base + IVA',
                                descripcion: _descriptionController.text,
                                moneda: _currencyService.selectedCurrency?.id ?? '',
                                fecha: DateTime.now().toIso8601String(),
                                estatus: 'Pendiente',
                                total: _amountController.text,
                                sucursal: '',
                                imagenes: [],
                              );

                              await paymentProvider.updateOrCreate(payment);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SuccessMessageView(
                                        title: 'Cobro creado con éxito',
                                        type: 'cobro',
                                        headerTitle: 'Reporte de cobro')),
                              );
                            }
                          },
                          child: Text(_currentStep == 0 ? 'Siguiente' : 'Registrar Cobro'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppTheme.greyBackground,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          if (_currentStep > 0) {
                            _goToStep(_currentStep - 1);
                          }
                        },
                        child: Text(
                          _currentStep == (_maxSteps - 1) ? 'Atrás' : 'Cancelar',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToStep(int stepIndex) {
    setState(() => _currentStep = stepIndex);
    _pageController.animateToPage(
      stepIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _showFacturaDropdown(BuildContext context) async {
    final billSelectionProvider = Provider.of<BillSelectionProvider>(context, listen: false);
    final selected = await CollectDialogs.showFacturaDropdown(
      context,
      '',
      billSelectionProvider,
    );

    if (selected != null) {
      billSelectionProvider.setSelectedFacturas(selected);
    }
  }

  Future<void> _showCurrencyDropdown(BuildContext context) async {
    final billSelectionProvider = Provider.of<BillSelectionProvider>(context, listen: false);
    final selected = await CollectDialogs.showCurrencyDropdown(
      context,
      _currencyService.currencies,
      billSelectionProvider,
    );

    if (selected != null) {
      _currencyService.setSelectedCurrency(selected);
    }
  }

  Future<void> _showPaymentMethodDropdown(BuildContext context) async {
    final provider = Provider.of<PaymentMethodProvider>(context, listen: false);
    final selected = await CollectDialogs.showPaymentMethodDropdown(context, provider);

    if (selected != null) {
      provider.setSelectedPaymentMethod(selected);
    }
  }

  Future<void> _showTipoDropdown(BuildContext context) async {
    final selected = await CollectDialogs.showTipoDropdown(
      context,
      _tipos,
      _selectedTipo,
    );

    if (selected != null) {
      setState(() {
        _selectedTipo = selected;
      });
    }
  }

  void _clearPaymentForm() {
    _titularCuentaController.clear();
    _titularRifController.clear();
    _referenciaController.clear();
    _fechaController.clear();
    _cobroController.clear();
    _baseController.clear();
    _ivaController.clear();
    _depositoController.clear();
    _amountController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedTipo = null;
    });
  }

  void _addPaymentMethod() {
    final paymentMethod = {
      'titular': _titularCuentaController.text,
      'rif': _titularRifController.text,
      'referencia': _referenciaController.text,
      'fecha': _fechaController.text,
      'cobro': _cobroController.text,
      'base': _baseController.text,
      'iva': _ivaController.text,
      'deposito': _depositoController.text,
      'monto': _amountController.text,
      'descripcion': _descriptionController.text,
      'tipo': _selectedTipo,
      'metodoPago': Provider.of<PaymentMethodProvider>(context, listen: false).selectedPaymentMethod?.descripcion,
    };

    setState(() {
      _paymentMethods.add(paymentMethod);
      _showSuccessMessage = true;
    });

    _successMessageTimer?.cancel();
    _successMessageTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _showSuccessMessage = false;
        });
      }
    });

    _clearPaymentForm();
  }
}

