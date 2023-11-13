import 'package:flutter/material.dart';

void main() {
  runApp(GerenciadorTarefasApp());
}

class GerenciadorTarefasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Tarefas',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TarefasScreen(),
    );
  }
}

class TarefasScreen extends StatefulWidget {
  @override
  _TarefasScreenState createState() => _TarefasScreenState();
}

class _TarefasScreenState extends State<TarefasScreen> {
  List<Tarefa> _tarefas = [];

  void _adicionarTarefa(String nome) {
    setState(() {
      _tarefas.add(Tarefa(nome: nome, concluida: false));
    });
  }

  void _alternarConclusao(int index) {
    setState(() {
      _tarefas[index].concluida = !_tarefas[index].concluida;
    });
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gerenciador de Tarefas')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_tarefas[index].nome),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    _removerTarefa(index);
                  },
                  child: ListTile(
                    title: Text(
                      _tarefas[index].nome,
                      style: TextStyle(
                        decoration: _tarefas[index].concluida
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: _tarefas[index].concluida
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                    leading: Checkbox(
                      value: _tarefas[index].concluida,
                      onChanged: (_) => _alternarConclusao(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _adicionarTarefa(value);
                }
              },
              decoration: InputDecoration(
                labelText: 'Adicionar Tarefa',
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Adicionar Tarefa'),
                content: TextField(
                  autofocus: true,
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _adicionarTarefa(value);
                      Navigator.pop(context);
                    }
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Tarefa {
  final String nome;
  bool concluida;

  Tarefa({required this.nome, required this.concluida});
}
