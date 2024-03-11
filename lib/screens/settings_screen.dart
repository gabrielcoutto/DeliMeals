import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/settings.dart';

class SettingsScreens extends StatefulWidget {
  const SettingsScreens(
      {super.key, this.onSettingsChanged, required this.settings});

  final Function(Settings)? onSettingsChanged;
  final Settings settings;

  @override
  State<SettingsScreens> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends State<SettingsScreens> {
  Settings? settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch({
    String? title,
    String? subtitle,
    bool? value,
    Function(bool)? onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title!),
      subtitle: Text(subtitle!),
      value: value!,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value) {
        onChanged!(value);
        widget.onSettingsChanged!(settings!);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      drawer: const MainDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Filtros',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _createSwitch(
                    title: 'Sem Glúten',
                    subtitle: 'Só exibe refeições sem Glúten!',
                    value: settings!.isGlutenFree,
                    onChanged: (value) => setState(() {
                      settings!.isGlutenFree = value;
                    }),
                  ),
                  _createSwitch(
                    title: 'Sem Lactose',
                    subtitle: 'Só exibe refeições sem Lactose!',
                    value: settings!.isLactoseFree,
                    onChanged: (value) => setState(() {
                      settings!.isLactoseFree = value;
                    }),
                  ),
                  _createSwitch(
                    title: 'Vegana',
                    subtitle: 'Só exibe refeições veganas!',
                    value: settings!.isVegan,
                    onChanged: (value) => setState(() {
                      settings!.isVegan = value;
                    }),
                  ),
                  _createSwitch(
                    title: 'Vegetariana',
                    subtitle: 'Só exibe refeições vegetarianas!',
                    value: settings!.isVegetarian,
                    onChanged: (value) => setState(() {
                      settings!.isVegetarian = value;
                    }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
