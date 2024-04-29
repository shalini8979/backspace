import 'package:backspace/const_widgets/textwidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}
class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {

    final mq= MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color:Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.purple,
        title: textWidget(color: Colors.white, onpress:(){}, 
        title: 'Articles List', fontsize: 18, fontWeight: FontWeight.bold),
      ),

      
      body: StreamBuilder(
        
        stream: FirebaseFirestore.instance.collection("Articles").snapshots(), 
        
        builder: (context, snapshot) {
          SizedBox(height: 20,);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No data found"));
          }

          // Determine the itemCount based on the minimum of snapshot length and 5
          int itemCount = snapshot.data!.docs.length < 5 ? snapshot.data!.docs.length : 5;

          // Display the list only if data is available
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            //  itemCount,
            itemBuilder: (context, index) {
              return SingleChildScrollView(
                child: Container(
                  height: mq.height*1/3,width: mq.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    
                    children: [
                      SizedBox(height: 30,),
                      
                      Container(
                  
                        height: mq.height*1/4,width: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network("${snapshot.data!.docs[index]['image']}")),
                  
                      ),
                  
                      SizedBox(height: 5,),
                  
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ArticleDetailsScreen(article: snapshot.data!.docs[index]),
                    ),
                  );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:20.0,right: 20.0),
                          child: Container(
                            height: 27.5,width: mq.width,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200),color: Colors.purple,),
                            child: ClipRRect(
                              child: Center(
                                child: textWidget(color: Colors.white, onpress: (){},
                                title: "${snapshot.data!.docs[index]['article_title']}", fontsize: 12, fontWeight: FontWeight.w600),
                              ),
                              
                            ),
                            
                          ),
                        ),
                      )
                  
                  
                    ],
                  ),
                  
                ),
              );
              // Container(
              //   margin: EdgeInsets.symmetric(vertical: 15), 
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.purple),
          
              //   height: 60,width: mq.width,
                
              //   child: ListTile(
                  
              //     titleTextStyle: TextStyle(),
              //     leading: CircleAvatar(
              //       child: Image.network("${snapshot.data!.docs[index]['image']}")
              //     ),
              //     title: GestureDetector(
              //       onTap: (){
                    
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) =>
              //             ArticleDetailsScreen(article: snapshot.data!.docs[index]),
              //       ),
              //     );
              //   },
                    
              //       child: textWidget(color: Colors.white, onpress: (){}, 
              //       title: "${snapshot.data!.docs[index]['article_title']}", fontsize: 16, fontWeight: FontWeight.w400)),
              //   ),
                
              // );
              
            },
            
          );
          
        },
        
      ),
    );
  }
}


class ArticleDetailsScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> article;

  const ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    

    final mq= MediaQuery.of(context).size;
    return Scaffold(
      
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color:Colors.purple),color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: textWidget(color: Colors.purple, onpress: (){},
        title:"Article Details", fontsize: 18, fontWeight: FontWeight.bold)
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: mq.height*1/4,width: mq.width,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white),
                  
                  child: ClipPath(child: Image.network(article['image'],fit: BoxFit.cover,)),),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(

                  
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 14,),
                    Center(child: textWidget(color: Color.fromARGB(223, 255, 255, 255), onpress: (){}, 
                    title: article['article_title'], fontsize: 24, fontWeight:FontWeight.bold)),

                    Divider(),

                    SizedBox(height: 8),
                    // Text('Author: ${article['author']}'),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(),
                      width: mq.width,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(2)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: textWidget(color: Colors.purple, onpress: (){}, title: article['content'], fontsize: 16, fontWeight: FontWeight.w400),
                      )),
                    Divider(height: 20, color: Color.fromARGB(255, 223, 220, 220), thickness: 2.0),

                    SizedBox(height: 30,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}