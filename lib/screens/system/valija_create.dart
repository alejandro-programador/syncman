import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/providers/zone_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/menu.dart';

class ValijaCreateView extends StatefulWidget {
  const ValijaCreateView({super.key});

  @override
  State<ValijaCreateView> createState() => _ValijaCreateViewState();
}

class _ValijaCreateViewState extends State<ValijaCreateView> {
  String? _selectedZone;
  final TextEditingController _montoController = TextEditingController();
  final TextEditingController _montoBSController = TextEditingController();
  final TextEditingController _observacionController = TextEditingController();
  final TextEditingController _comentarioController = TextEditingController();
  final List<String> _selectedCobros = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ZoneProvider>().loadZones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final zones = context.watch<ZoneProvider>().zones;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          children: [
            Text(
              "Crear Valija",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuView()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppTheme.greyBackground,
          margin: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Zone Selection
              Text('ZONA',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: _selectedZone,
                  hint: Text(
                    'Seleccionar zona',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  underline: const SizedBox(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedZone = newValue;
                    });
                  },
                  items: zones
                      .map((zone) => DropdownMenuItem<String>(
                            value: zone.id,
                            child: Text(zone.descripcion,
                                style: Theme.of(context).textTheme.labelMedium),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 16),

              // Monto Section
              Text('MONTO',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _montoController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ingrese el monto',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Monto BS Section
              Text('MONTO BS',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _montoBSController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Ingrese el monto en bolívares',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Observación Section
              Text('OBSERVACIÓN',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _observacionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Escribir observación...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Comentario Section
              Text('COMENTARIO',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _comentarioController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Escribir comentario...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),

              // Buttons Section
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        // Validate required fields
                        if (_selectedZone == null) {
                          showCustomDialog(context, 'Por favor seleccione una zona', false);
                          return;
                        }

                        if (_montoController.text.isEmpty) {
                          showCustomDialog(context, 'Por favor ingrese el monto', false);
                          return;
                        }

                        // Create valija data
                        final valijaData = {
                          "zona": _selectedZone,
                          "cobros": _selectedCobros,
                          "monto": double.parse(_montoController.text),
                          "montoBS": double.parse(_montoBSController.text),
                          "observacion": _observacionController.text,
                          "comentario": _comentarioController.text,
                        };
                        
                        // Show success message
                        showCustomDialog(context, 'Valija creada exitosamente', true);
                      },
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
                      child: Text('Crear Valija',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16.0)),
                    child: Text('Cancelar', style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }

  void showCustomDialog(BuildContext context, String message, bool isSuccess) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Éxito' : 'Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (isSuccess) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}