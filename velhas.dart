import "dart:io";
class Tabuleiro{
  List <dynamic> tabuleiro = [];

  Tabuleiro(List <dynamic> tabuleiro){
    this.tabuleiro = tabuleiro;
  }

  void printTabuleiro(){
    return print('''

  0 1 2
0 ${tabuleiro[0][0]}|${tabuleiro[0][1]}|${tabuleiro[0][2]}
1 ${tabuleiro[1][0]}|${tabuleiro[1][1]}|${tabuleiro[1][2]}
2 ${tabuleiro[2][0]}|${tabuleiro[2][1]}|${tabuleiro[2][2]}
''');
  }

  void alterarTabuleiro(x, y, p){ //p = player = X ou O
    tabuleiro[x][y] = p;
  }
}

class Jogo{
  late bool gamerun;

  Jogo(bool gamerun){
    this.gamerun = gamerun;
  }

  void start(){
    final List <dynamic> tabuleiro = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "],];
    Tabuleiro tab = Tabuleiro(tabuleiro);
    while(gamerun == true){
      for(int i=1; i<=9; i++){
        if (i%2 == 0){
          stdout.writeln();
          print("Turno do O:");
          tab.printTabuleiro();
          print("Selecione em qual linha você deseja jogar:");
          String? inx = stdin.readLineSync();
          tab.printTabuleiro();
          print("Selecione em qual coluna você deseja jogar:");
          String? iny = stdin.readLineSync();
          int intx = int.parse(inx!);
          int inty = int.parse(iny!); 
          tab.alterarTabuleiro(intx, inty, "O");
        }
        else{
          stdout.writeln();
          print("Turno do X:");
          tab.printTabuleiro();
          print("Selecione em qual linha você deseja jogar:");
          String? inx = stdin.readLineSync();
          tab.printTabuleiro();
          print("Selecione em qual coluna você deseja jogar:");
          String? iny = stdin.readLineSync();
          int intx = int.parse(inx!);
          int inty = int.parse(iny!); 
          tab.alterarTabuleiro(intx, inty, "X");
        }
      gamerun = false;
      }
    }
  }
  //para fazer os turnos usar números impares para decidir de quem é o turno
  //EX: i = 1, se for impar vez da bolinha, i++ vira par é vez do x
}

void main(){
  Jogo game = Jogo(true);
  bool run = true;
  while (run == true) {
    print('''

===========================================
Seja bem vindo ao jogo da velha do Schumann
===========================================

Digite 0 para sair ou 1 para jogar:''');
  String? input = stdin.readLineSync();
  if (input == "0"){
    run = false;
  }
  else{
    game.start();
  }   
  }
}

/*TODO:
transformar a parte do game.start() em uma função
if tab[x][y] != " "
tratamento de erro
<0 >2 erro
casa ocupada
verificação de vencedor*/