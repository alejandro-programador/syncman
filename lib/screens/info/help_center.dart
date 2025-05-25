import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/theme/theme.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              Text(
                "Centro de ayuda",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: const [
              Tab(
                text: "FAQ",
              ),
              Tab(text: "Contacto"),
            ],
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            labelStyle: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
                color: AppTheme.greyColor),
          ),
        ),
        body: const TabBarView(
          children: [
            FAQView(),
            ContactoView(),
          ],
        ),
      ),
    );
  }
}

class FAQView extends StatefulWidget {
  const FAQView({super.key});

  @override
  FAQViewState createState() => FAQViewState();
}

class FAQViewState extends State<FAQView> {
  final List<String> categories = [
    "General",
    "Cuenta",
    "Servicio",
    "Modo supervisor"
  ];
  String selectedCategory = "General";
  final List<Map<String, dynamic>> faqItems = [
    {
      "question": "What is Potea?",
      "answer": "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
      "isExpanded": false
    },
    {
      "question": "¿Cómo comprar?",
      "answer":
          "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      "isExpanded": false
    },
    {
      "question": "How do I cancel an order?",
      "answer": "Excepteur sint occaecat cupidatat non proident.",
      "isExpanded": false
    },
    {
      "question": "Is Potea free to use?",
      "answer":
          "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.",
      "isExpanded": false
    },
    {
      "question": "How to add promo when checkout?",
      "answer":
          "Duis aute irure dolor in reprehenderit in voluptate velit esse.",
      "isExpanded": false
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: categories.map((category) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  showCheckmark: false,
                  label: Text(category,
                      style: context.textTheme.labelMedium?.copyWith(
                          color: selectedCategory == category
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w700)),
                  selected: selectedCategory == category,
                  onSelected: (selected) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: AppTheme.greyBackground,
                  labelStyle: TextStyle(
                      color: selectedCategory == category
                          ? Colors.white
                          : Colors.black),
                ),
              );
            }).toList(),
          ),
        ),
        // Search Bar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Por qué...",
              hintStyle: context.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
              prefixIcon: const Icon(
                Icons.search,
                color: AppTheme.primaryColor,
              ),
              suffixIcon: const Icon(Icons.tune, color: AppTheme.primaryColor),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        // FAQ List
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8.0), // Optional: Rounded corners
                ),
                child: ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      faqItems[index]['isExpanded'] = !isExpanded;
                    });
                  },
                  children: faqItems.map<ExpansionPanel>((item) {
                    return ExpansionPanel(
                      backgroundColor: Colors.white,
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                          title: Text(item['question'],
                              style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins')),
                        );
                      },
                      body: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(item['answer'],
                            style: context.textTheme.labelMedium?.copyWith(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins')),
                      ),
                      isExpanded: item['isExpanded'],
                      canTapOnHeader: true,
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ContactoView extends StatefulWidget {
  const ContactoView({super.key});

  @override
  State<ContactoView> createState() => _ContactoViewState();
}

class _ContactoViewState extends State<ContactoView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FAQ List
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 1,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.email,
                          size: 25,
                        ),
                        title: Text("Soporte técnico",
                            style: context.textTheme.bodyMedium),
                        iconColor: Colors.blue,
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.public,
                          size: 25,
                        ),
                        title: Text("Sitio web",
                            style: context.textTheme.bodyMedium),
                        iconColor: Colors.blue,
                        textColor: Colors.blue,
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const FaIcon(
                          FontAwesomeIcons.instagram,
                          color: Colors.blue,
                          size: 25,
                        ),
                        title: Text("Instagram",
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: AppTheme.primaryColor,
                            )),
                        iconColor: Colors.blue,
                        textColor: AppTheme.primaryColor,
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.privacy_tip,
                          size: 25,
                        ),
                        title: Text(
                          "Política de privacidad",
                          style: context.textTheme.bodyMedium
                              ?.copyWith(color: Colors.blue),
                        ),
                        iconColor: Colors.blue,
                        textColor: Colors.blue,
                        onTap: () {
                          Navigator.pushNamed(context, "/privacy-policy");
                        },
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
