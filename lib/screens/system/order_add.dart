import 'package:flutter/material.dart';

class OrderAddView extends StatefulWidget {
  const OrderAddView({super.key});

  @override
  OrderAddViewState createState() => OrderAddViewState();
}

class OrderAddViewState extends State<OrderAddView> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _idController = TextEditingController();
  final _descripcionController = TextEditingController();
  final _fecEmisController = TextEditingController();
  final _fecVencController = TextEditingController();
  final _totalBrutoController = TextEditingController();
  final _totalNetoController = TextEditingController();
  final _saldoController = TextEditingController();

  // Valores seleccionables
  String? _cliente;
  String? _transporte;
  String? _moneda;
  String? _vendedor;
  String? _condicionPago;
  String? _ctaIngrEgr;
  String? _sucursal;

  // Valores booleanos
  bool _anulado = false;
  bool _impresa = false;
  bool _contrib = true;

  @override
  void dispose() {
    _idController.dispose();
    _descripcionController.dispose();
    _fecEmisController.dispose();
    _fecVencController.dispose();
    _totalBrutoController.dispose();
    _totalNetoController.dispose();
    _saldoController.dispose();
    super.dispose();
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // final orderData = {
      //   "_id": _idController.text,
      //   "descripcion": _descripcionController.text,
      //   "cliente": _cliente,
      //   "transporte": _transporte,
      //   "moneda": _moneda,
      //   "vendedor": _vendedor,
      //   "condicionPago": _condicionPago,
      //   "ctaIngrEgr": _ctaIngrEgr,
      //   "fecEmis": _fecEmisController.text,
      //   "fecVenc": _fecVencController.text,
      //   "anulado": _anulado,
      //   "impresa": _impresa,
      //   "contrib": _contrib,
      //   "totalBruto": double.tryParse(_totalBrutoController.text) ?? 0,
      //   "totalNeto": double.tryParse(_totalNetoController.text) ?? 0,
      //   "saldo": double.tryParse(_saldoController.text) ?? 0,
      //   "sucursal": _sucursal,
      //   "renglones": [],
      //   "seriales": [],
      // };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Pedido")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_idController, "ID del Pedido"),
              _buildTextField(_descripcionController, "Descripción"),
              _buildDropdownField("Cliente", _cliente, ["Cliente1-ID", "Cliente2-ID"],
                  (value) => setState(() => _cliente = value)),
              _buildDropdownField("Transporte", _transporte, ["Transporte1-ID", "Transporte2-ID"],
                  (value) => setState(() => _transporte = value)),
              _buildDropdownField("Moneda", _moneda, ["Moneda1-ID", "Moneda2-ID"],
                  (value) => setState(() => _moneda = value)),
              _buildDropdownField("Vendedor", _vendedor, ["Vendedor1-ID", "Vendedor2-ID"],
                  (value) => setState(() => _vendedor = value)),
              _buildDropdownField(
                  "Condición de Pago",
                  _condicionPago,
                  ["Condicion1-ID", "Condicion2-ID"],
                  (value) => setState(() => _condicionPago = value)),
              _buildDropdownField("Cuenta Ingreso/Egreso", _ctaIngrEgr,
                  ["Cuenta1-ID", "Cuenta2-ID"], (value) => setState(() => _ctaIngrEgr = value)),
              _buildDateField(_fecEmisController, "Fecha de Emisión"),
              _buildDateField(_fecVencController, "Fecha de Vencimiento"),
              _buildSwitchField("Anulado", _anulado, (value) => setState(() => _anulado = value)),
              _buildSwitchField("Impresa", _impresa, (value) => setState(() => _impresa = value)),
              _buildSwitchField(
                  "Contribuyente", _contrib, (value) => setState(() => _contrib = value)),
              _buildTextField(_totalBrutoController, "Total Bruto"),
              _buildTextField(_totalNetoController, "Total Neto"),
              _buildTextField(_saldoController, "Saldo"),
              _buildDropdownField("Sucursal", _sucursal, ["Sucursal1-ID", "Sucursal2-ID"],
                  (value) => setState(() => _sucursal = value)),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _submitOrder,
                  child: const Text("Enviar Pedido"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      validator: (value) => value!.isEmpty ? "Ingrese $label" : null,
    );
  }

  Widget _buildDropdownField(
      String label, String? value, List<String> items, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: label),
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Seleccione $label" : null,
    );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() => controller.text = pickedDate.toIso8601String());
        }
      },
    );
  }

  Widget _buildSwitchField(String label, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(label),
      value: value,
      onChanged: onChanged,
    );
  }
}
