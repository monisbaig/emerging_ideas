import 'package:emerging_ideas/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

import '../cubits/ideas_cubit.dart';
import '../model/ideas_model.dart';

class IdeaList extends StatelessWidget {
  final List<IdeasModel> ideas;

  const IdeaList({Key? key, required this.ideas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ideas.length,
      itemBuilder: (context, index) {
        final idea = ideas[index];
        return idea.title == null
            ? const Center(
                child: Text(
                  'No Post',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              )
            : GFListTile(
                avatar: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(idea.imgLink!),
                ),
                title: Text(
                  idea.title!,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                description: Text(
                  idea.description!,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                icon: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BlocProvider.value(
                              value: BlocProvider.of<IdeasCubit>(context),
                              child: EditDialog(ideasModel: idea),
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<IdeasCubit>(context).deleteIdea(
                          id: idea.id!,
                          email: idea.email!,
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.yellow,
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
