import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/colors.dart';
import '../../utils/styles.dart';
import '../../view_model/user_view_model/feedback_provider.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    var heightX = MediaQuery.of(context).size.height;
    var widthX = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: heightX * 0.04,
            color: AppColors.whiteColor,
          ),
        ),
        centerTitle: true,
        title: Text('View Feedback',
            style: secondaryTextStyle.copyWith(
                color: AppColors.whiteColor, fontSize: widthX * 0.063)),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<FeedbackProvider>(context).getFeedBacks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No feedback available"));
          }



          return SizedBox(
            height: heightX * 0.8,
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var feedbackList = snapshot.data!.docs[index];

                return Card(
                  elevation: 4,
                  color: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:
                 Padding(
                   padding: const EdgeInsets.all(15),
                   child: Row(
                     children: [
                       // Container(
                       //   height: heightX * 0.09,
                       //   width: heightX * 0.09,
                       //   decoration: BoxDecoration(
                       //     borderRadius: BorderRadius.circular(10),
                       //     image: DecorationImage(
                       //         fit: BoxFit.cover,
                       //         image: feedbackList['image_url'] != null && feedbackList['image_url'] != ''? NetworkImage(feedbackList['image_url']) : const AssetImage(Assets.dp))
                       //   ),
                       // ),
                       Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(
                             'Name: ${feedbackList['name'] }',
                             style: smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                           ),
                           Text(
                             overflow: TextOverflow.ellipsis,
                             'Email: ${feedbackList['email'] }',
                             style: smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                           ),
                           Text(
                             overflow: TextOverflow.ellipsis,
                             maxLines: 5,
                             'Message: ${feedbackList['message'] }',
                             style: smallTextStyle.copyWith(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                           ),

                         ],
                       ),
                     ],
                   ),
                 ),

                );
              },
            ),
          );
        },
      ),
    );
  }
}
