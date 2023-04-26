import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_share_with_pone_auth/constants/constant_data.dart';
import 'package:video_share_with_pone_auth/constants/design_elements.dart';
import 'package:video_share_with_pone_auth/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentSection extends StatelessWidget {
  CommentSection({super.key, required this.id});
  final String id;
  TextEditingController _commentController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(id);
    return Column(children: [
      Expanded(
        child: Obx(() {
          return ListView.builder(
              itemCount: commentController.comments.length,
              itemBuilder: (context, index) {
                final comment = commentController.comments[index];
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          comment.profilePhoto) //add image url here,
                      ),
                  title: Row(
                    children: [
                      Text(
                        comment.name,
                        style: subHeading.copyWith(color: primaryColor),
                      ),
                    ],
                  ),
                  trailing: InkWell(
                    onTap: () => commentController.likeComment(comment.id),
                    child: Icon(
                      comment.likes.contains(authController.user.uid)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      size: 25,
                      color: primaryColor,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.comment,
                        style: bodyText.copyWith(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(children: [
                        Text(tago.format(comment.datePublished.toDate())),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${comment.likes.length} Likes')
                      ]),
                    ],
                  ),
                );
              });
        }),
      ),
      Divider(
        color: primaryColor,
      ),
      ListTile(
        title: TextFormField(
          textInputAction: TextInputAction.send,
          controller: _commentController,
          maxLines: 3,
          style: TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelStyle: heading,
            label: Text(
              "Comment",
              style: subHeading.copyWith(color: primaryColor),
            ),
            border: InputBorder.none,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            commentController.postComment(_commentController.text);
            // _commentController.clear();
          },
          icon: Icon(
            Icons.send_rounded,
            color: primaryColor,
          ),
        ),
      )
    ]);
  }
}
