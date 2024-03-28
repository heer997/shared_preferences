import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SharedPractice3(),
    );
  }
}
class SharedPractice3 extends StatefulWidget
{
  const SharedPractice3({super.key});
  @override
  State<SharedPractice3> createState()
  {
    return SharedPractice3State();
  }
}
class SharedPractice3State extends State<SharedPractice3>
{
  final TextEditingController _controller = TextEditingController();
  String _savedText = "";

  @override
  void initState()
  {
    _getString();
    super.initState();
  }

  Future<void> _getString() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _savedText = preferences.getString("keyName") ?? "";
    },);
  }

  Future<void> _setString(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("keyName", text) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: SizedBox(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter the Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  _setString(_controller.text);
                  setState(() {
                    _savedText = _controller.text;
                  },);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0,50.0),
                ),
                child: const Text("Save Text : ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),),
              ),
              const SizedBox(height: 40.0),
              Text("Save Text : $_savedText",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NextPage2();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0,50.0),
                ),
                child: const Text("Go to Next Page",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class NextPage2 extends StatefulWidget
{
  const NextPage2({super.key});
  @override
  State<NextPage2> createState()
  {
    return NextPage2State();
  }
}
class NextPage2State extends State<NextPage2>
{
  String name = "";

  @override
  void initState()
  {
    _getString();
    super.initState();
  }

  Future<void> _getString() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      name = preferences.getString("keyName") ?? "";
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
      ),
    );
  }
}