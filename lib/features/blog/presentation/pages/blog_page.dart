import 'package:blogapp/core/common/widgets/custom_loader.dart';
import 'package:blogapp/core/theme/app_color.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blogapp/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blogapp/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    // Fetch all blogs when the page is initialized
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Blog App')),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the AddNewBlogPage
              Navigator.push(context, AddNewBlogPage.route());
            },
            icon: const Icon(CupertinoIcons.add_circled),
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return const CustomLoader();
          } else if (state is BlogDisplaySuccess) {
            // Show the list of blogs when the data is successfully fetched
            final blogs = state.blogs;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                final blog = blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 2 == 0
                      ? AppPallete.gradient1
                      : AppPallete.gradient2,
                );
              },
            );
          } else if (state is BlogFailure) {
            // Show an error message if something goes wrong
            //TODo
            return Center(child: Text('Error: ${state.error}'));
          } else {
            // Default state (e.g., initial state)
            return const Center(child: Text('No blogs available.'));
          }
        },
      ),
    );
  }
}
