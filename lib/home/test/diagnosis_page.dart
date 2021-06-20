import 'package:flutter/material.dart';
import 'package:labyrinth/helper/size_config.dart';
import 'package:labyrinth/home/home_page.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class DiagnosisPage extends StatefulWidget {
  DiagnosisPage({this.disease});

  final String disease;

  @override
  _DiagnosisPageState createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  int choosedMarker;
  String choosedMarkerText = "";
  String choosedMarkerAddress = "";

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    var markers = <Marker>[
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(46.9942508, 28.7983955),
        builder: (ctx) => IconButton(
            icon: Icon(
              choosedMarker == 0 ? Icons.place : Icons.place_rounded,
              color: choosedMarker == 0 ? Colors.blue : Colors.red,
              size: 50,
            ),
            onPressed: () {
              setState(() {
                choosedMarker = 0;
                choosedMarkerText = "Centrul de Reabilitare „Recovery”";
                choosedMarkerAddress = "Strada Vasile Lupu 42, Chișinău";
              });
            }),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(47.007937, 28.8246645),
        builder: (ctx) => IconButton(
            icon: Icon(
              choosedMarker == 1 ? Icons.place : Icons.place_rounded,
              color: choosedMarker == 1 ? Colors.blue : Colors.red,
              size: 50,
            ),
            onPressed: () {
              setState(() {
                choosedMarker = 1;
                choosedMarkerText = "Centrul de Criză Mintală Drăgan";
                choosedMarkerAddress = "Strada Maria Drăgan 30/3, Chișinău";
              });
            }),
      ),
      Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(46.9745768, 28.8097252),
        builder: (ctx) => IconButton(
            icon: Icon(
              choosedMarker == 2 ? Icons.place : Icons.place_rounded,
              color: choosedMarker == 2 ? Colors.blue : Colors.red,
              size: 50,
            ),
            onPressed: () {
              setState(() {
                choosedMarker = 2;
                choosedMarkerText = "TerraMed";
                choosedMarkerAddress = "Trandafirilor Street 15/4, Chișinău";
              });
            }),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              })
        ],
        leading: Container(),
      ),
      body: _buildBody(markers),
    );
  }

  _buildBody(List<Marker> markers) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.adaptWidth(6)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.adaptHeight(2),
            ),
            Text(
              "Detected: " + widget.disease,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.adaptFontSize(6),
                  color: Colors.white),
            ),
            Text(
              "Specialist:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.adaptFontSize(6),
                  color: Colors.white),
            ),
            SizedBox(
              height: SizeConfig.adaptHeight(1),
            ),
            Stack(
              children: [
                Container(
                  height: SizeConfig.adaptHeight(60),
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(47.001670, 28.808089),
                      zoom: 12.0,
                    ),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                        subdomains: ['a', 'b', 'c'],
                        tileProvider: NonCachingNetworkTileProvider(),
                      ),
                      MarkerLayerOptions(markers: markers),
                    ],
                  ),
                ),
                choosedMarker != null
                    ? Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.adaptHeight(48),
                            left: SizeConfig.adaptWidth(4)),
                        padding:
                            EdgeInsets.only(top: SizeConfig.adaptHeight(2)),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white),
                        width: SizeConfig.adaptWidth(80),
                        height: SizeConfig.adaptHeight(10),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Text(
                                  choosedMarkerText,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.adaptWidth(16)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Medical clinic",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Website",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  choosedMarkerAddress,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                bottom: SizeConfig.adaptHeight(2),
                              ),
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.grey[350],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      choosedMarker = null;
                                    });
                                  }),
                            ),
                          ],
                        ))
                    : Container(),
              ],
            ),
            SizedBox(
              height: SizeConfig.adaptHeight(2),
            ),
            Text(
              "Description:",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.adaptFontSize(6),
                  color: Colors.white),
            ),
            SizedBox(
              height: SizeConfig.adaptHeight(1),
            ),
            RichText(
                text: TextSpan(
                  text: widget.disease == "Bipolar"
                      ? """
            Bipolar disorder, formerly called manic depression, is a mental health condition that causes extreme mood swings that include emotional highs (mania or hypomania) and lows (depression).
            When you become depressed, you may feel sad or hopeless and lose interest or pleasure in most activities. When your mood shifts to mania or hypomania (less extreme than mania), you may feel euphoric, full of energy or unusually irritable. These mood swings can affect sleep, energy, activity, judgment, behavior and the ability to think clearly.
            Episodes of mood swings may occur rarely or multiple times a year. While most people will experience some emotional symptoms between episodes, some may not experience any.
            Although bipolar disorder is a lifelong condition, you can manage your mood swings and other symptoms by following a treatment plan. In most cases, bipolar disorder is treated with medications and psychological counseling (psychotherapy).
            """
                      : widget.disease == "Depression"
                          ? """
            Depression is a state of low mood and aversion to activity. It can affect a person's thoughts, behavior, motivation, feelings, and sense of well-being.
            The core symptom of depression is said to be anhedonia, which refers to loss of interest or a loss of feeling of pleasure in certain activities that usually bring joy to people.
            Depressed mood is a symptom of some mood disorders such as major depressive disorder or dysthymia; it is a normal temporary reaction to life events, such as the loss of a loved one; and it is also a symptom of some physical diseases and a side effect of some drugs and medical treatments. It may feature sadness, difficulty in thinking and concentration and a significant increase or decrease in appetite and time spent sleeping. People experiencing depression may have feelings of dejection, hopelessness and, sometimes, suicidal thoughts. It can either be short term or long term.
            """
                          : widget.disease == "Dementia"
                              ? """
            Dementia manifests as a set of related symptoms, which usually surface when the brain is damaged by injury or disease. The symptoms involve progressive impairments to memory, thinking, and behavior, which negatively impact a person's ability to function and carry out everyday activities.
            Aside from memory impairment and a disruption in thought patterns, the most common symptoms include emotional problems, difficulties with language, and decreased motivation.
            Dementia is not a disorder of consciousness, and consciousness is not usually affected.
            The symptoms may be described as occurring in a continuum over several stages. A diagnosis of dementia requires a change from a person's usual mental functioning and a greater cognitive decline than that due to normal aging.
            """
                              : widget.disease == "Schizophrenia"
                                  ? """
            Schizophrenia is a serious mental disorder in which people interpret reality abnormally. Schizophrenia may result in some combination of hallucinations, delusions, and extremely disordered thinking and behavior that impairs daily functioning, and can be disabling.
            People with schizophrenia require lifelong treatment. Early treatment may help get symptoms under control before serious complications develop and may help improve the long-term outlook.
            Schizophrenia involves a range of problems with thinking (cognition), behavior and emotions. Signs and symptoms may vary, but usually involve delusions, hallucinations or disorganized speech, and reflect an impaired ability to function. Symptoms may include:
            Delusions. These are false beliefs that are not based in reality. For example, you think that you're being harmed or harassed; certain gestures or comments are directed at you; you have exceptional ability or fame; another person is in love with you; or a major catastrophe is about to occur. Delusions occur in most people with schizophrenia.
            Hallucinations. These usually involve seeing or hearing things that don't exist. Yet for the person with schizophrenia, they have the full force and impact of a normal experience. Hallucinations can be in any of the senses, but hearing voices is the most common hallucination.
            Disorganized thinking (speech). Disorganized thinking is inferred from disorganized speech. Effective communication can be impaired, and answers to questions may be partially or completely unrelated. Rarely, speech may include putting together meaningless words that can't be understood, sometimes known as word salad.
            """
                                  : "",
                  style: TextStyle(
                      fontSize: SizeConfig.adaptFontSize(4),
                      color: Colors.white),
                ),
                textAlign: TextAlign.justify),
            Align(
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurple[900])),
                  onPressed: () {
                    print("No");
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.adaptHeight(2),
                        horizontal: SizeConfig.adaptWidth(5)),
                    child: Text(
                      "Read more",
                      style: TextStyle(
                        fontSize: SizeConfig.adaptFontSize(6),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.adaptHeight(2),
            ),
          ],
        ),
      ),
    );
  }
}
