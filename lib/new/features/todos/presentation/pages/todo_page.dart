import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/new/features/todos/presentation/viewmodels/todo_page_viewmodel.dart';
import 'package:to_do_app/new/features/todos/presentation/widgets/todo_confirm_delete.dart';
import 'package:to_do_app/new/features/todos/presentation/widgets/todo_form_dialog.dart';
import 'package:to_do_app/new/features/todos/presentation/widgets/todo_confirm_status.dart';
import 'package:to_do_app/new/features/todos/presentation/widgets/todo_item.dart';
import '../../../../core/di/dependency_container.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoPageViewmodel>(
      create: (_) => getIt<TodoPageViewmodel>()..getTodos(),
      child: const TodoPageBody(),
    );
  }
}

class TodoPageBody extends StatelessWidget {
  const TodoPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<TodoPageViewmodel>();

    if (Platform.isIOS) {
      // iOS style
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: vm.isSearching
              ? CupertinoSearchTextField(onChanged: vm.searchTodos)
              : const Text('Todos'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(vm.isSearching ? CupertinoIcons.clear : CupertinoIcons.search),
                onPressed: vm.toggleSearch,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(CupertinoIcons.ellipsis_vertical),
                onPressed: () => _showDrawerSheet(context, vm),
              ),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildIOSList(context, vm),
              _buildIOSFloatingButton(context, vm),
            ],
          ),
        ),
      );
    } else {
      // Android style
      return Scaffold(
        appBar: AppBar(
          title: vm.isSearching
              ? TextField(
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Search todos...',
              border: InputBorder.none,
            ),
            onChanged: vm.searchTodos,
          )
              : const Text('Todos'),
          actions: [
            IconButton(
              icon: Icon(vm.isSearching ? Icons.close : Icons.search),
              onPressed: vm.toggleSearch,
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                child: Text('Menu', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white)),
              ),
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text('All Todos'),
                onTap: () {
                  Navigator.pop(context);
                  // vm.setFilter('all');
                },
              ),
              ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: const Text('Active Todos'),
                onTap: () {
                  Navigator.pop(context);
                  // vm.setFilter('active');
                },
              ),
              ListTile(
                leading: const Icon(Icons.done_all),
                title: const Text('Completed Todos'),
                onTap: () {
                  Navigator.pop(context);
                  // vm.setFilter('completed');
                },
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: vm.getTodos,
          child: _buildAndroidList(context, vm),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showTodoDialog(context, const TodoFormDialog()),
          child: const Icon(Icons.add),
        ),
      );
    }
  }

  // ====================== IOS ======================
  Widget _buildIOSList(BuildContext context, TodoPageViewmodel vm) {
    if (vm.isFetching) return const Center(child: CupertinoActivityIndicator());

    final todos = vm.filteredTodos;
    if (todos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(CupertinoIcons.check_mark_circled, size: 64, color: CupertinoColors.inactiveGray),
            const SizedBox(height: 16),
            const Text('No todos yet', style: TextStyle(color: CupertinoColors.inactiveGray)),
            CupertinoButton(onPressed: vm.getTodos, child: const Text('Refresh')),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: vm.getTodos),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final todo = todos[index];
              return TodoItem(
                key: ValueKey(todo.id),
                todo: todo,
                onToggle: () => _showTodoDialog(context, TodoConfirmStatus(todo: todo)),
                onUpdate: () => _showTodoDialog(context, TodoFormDialog(todo: todo)),
                onDelete: () => _showTodoDialog(context, TodoConfirmDelete(todo: todo)),
              );
            },
            childCount: todos.length,
          ),
        ),
      ],
    );
  }

  Widget _buildIOSFloatingButton(BuildContext context, TodoPageViewmodel vm) {
    return Positioned(
      bottom: 16,
      right: 16,
      child: CupertinoButton(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(30),
        color: CupertinoColors.activeBlue,
        child: const Icon(CupertinoIcons.add, color: CupertinoColors.white),
        onPressed: () => _showTodoDialog(context, const TodoFormDialog()),
      ),
    );
  }

  // ====================== ANDROID ======================
  Widget _buildAndroidList(BuildContext context, TodoPageViewmodel vm) {
    if (vm.isFetching) return ListView(children: const [Center(child: CircularProgressIndicator())]);

    final todos = vm.filteredTodos;
    if (todos.isEmpty) {
      return ListView(
        children: [
          const SizedBox(height: 50),
          const Center(child: Text('No todos yet')),
          TextButton(onPressed: vm.getTodos, child: const Text('Refresh')),
        ],
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          key: ValueKey(todo.id),
          todo: todo,
          onToggle: () => _showTodoDialog(context, TodoConfirmStatus(todo: todo)),
          onUpdate: () => _showTodoDialog(context, TodoFormDialog(todo: todo)),
          onDelete: () => _showTodoDialog(context, TodoConfirmDelete(todo: todo)),
        );
      },
    );
  }
}

// ====================== DIALOG ======================
void _showTodoDialog(BuildContext context, Widget dialog) {
  final vm = context.read<TodoPageViewmodel>();

  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: vm,
        child: AbsorbPointer(
          absorbing: vm.isMutating,
          child: Stack(
            children: [
              dialog,
              if (vm.isMutating)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0x66000000),
                    child: Center(child: CupertinoActivityIndicator()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => ChangeNotifierProvider.value(
        value: vm,
        child: AbsorbPointer(
          absorbing: vm.isMutating,
          child: Stack(
            children: [
              dialog,
              if (vm.isMutating)
                const Positioned.fill(
                  child: ColoredBox(
                    color: Color(0x66000000),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer-style menu dùng ActionSheet trên iOS
void _showDrawerSheet(BuildContext context, TodoPageViewmodel vm) {
  showCupertinoModalPopup(
    context: context,
    builder: (_) => CupertinoActionSheet(
      title: const Text('Menu'),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            // vm.setFilter('all');
          },
          child: const Text('All Todos'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            // vm.setFilter('active');
          },
          child: const Text('Active Todos'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            Navigator.pop(context);
            // vm.setFilter('completed');
          },
          child: const Text('Completed Todos'),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () => Navigator.pop(context),
        child: const Text('Cancel'),
      ),
    ),
  );
}
