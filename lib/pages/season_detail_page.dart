import 'package:flutter/material.dart';
import '../../models/season_task.dart';
import '../../models/recipe.dart';
import '../../utils/storage_service.dart';

class SeasonDetailPage extends StatefulWidget {
  final String season;
  const SeasonDetailPage({super.key, required this.season});

  @override
  State<SeasonDetailPage> createState() => _SeasonDetailPageState();
}

class _SeasonDetailPageState extends State<SeasonDetailPage> {
  List<SeasonTask> _seasonTasks = [];
  List<Recipe> _seasonRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadSeasonData();
  }

  void _loadSeasonData() {
    // Récupère les tâches et recettes du stockage
    _seasonTasks = StorageService.getSeasonTasks(widget.season);
    _seasonRecipes = StorageService.getRecipes(season: widget.season);
  }

  Color _seasonColor() {
    switch (widget.season.toLowerCase()) {
      case 'printemps':
        return Colors.green;
      case 'été':
      case 'ete':
        return Colors.orange;
      case 'automne':
        return Colors.brown;
      case 'hiver':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _seasonColor();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.season),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tâches saisonnières',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _seasonTasks.length,
                itemBuilder: (context, index) {
                  final task = _seasonTasks[index];
                  return Card(
                    child: ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.category ?? ''),
                      trailing: Icon(
                        task.completed ? Icons.check_circle : Icons.circle_outlined,
                        color: task.completed ? Colors.green : Colors.grey,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Recettes & Conseils',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _seasonRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = _seasonRecipes[index];
                  return Card(
                    child: ListTile(
                      title: Text(recipe.title),
                      subtitle: Text(recipe.category),
                      onTap: () {
                        // Affiche le contenu de la recette
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text(recipe.title),
                            content: Text(recipe.content), // ⚡ ici tu peux ajouter plus de détails
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Fermer'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}