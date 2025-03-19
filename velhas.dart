import "dart:io";

class Tabuleiro {
  List<dynamic> tabuleiro = [];

  Tabuleiro(List<dynamic> tabuleiro) {
    this.tabuleiro = tabuleiro;
  }

  void printTabuleiro() {
    return print('''

  0 1 2
0 ${tabuleiro[0][0]}|${tabuleiro[0][1]}|${tabuleiro[0][2]}
1 ${tabuleiro[1][0]}|${tabuleiro[1][1]}|${tabuleiro[1][2]}
2 ${tabuleiro[2][0]}|${tabuleiro[2][1]}|${tabuleiro[2][2]}
''');
  }

  void alterarTabuleiro(x, y, p) {
    //p = player = X ou O
    tabuleiro[x][y] = p;
  }
}

class Jogo {
  late bool gamerun;

  Jogo(bool gamerun) {
    this.gamerun = gamerun;
  }

  void start() {
    final List<dynamic> tabuleiro = [
      [" ", " ", " "],
      [" ", " ", " "],
      [" ", " ", " "],
    ];
    Tabuleiro tab = Tabuleiro(tabuleiro);

    while (gamerun == true) {
      List<int> turn(String p) {
        stdout.writeln();
        print("Turno do $p:");
        tab.printTabuleiro();
        print("Selecione em qual linha você deseja jogar:");
        String? inx = stdin.readLineSync();
        tab.printTabuleiro();
        print("Selecione em qual coluna você deseja jogar:");
        String? iny = stdin.readLineSync();
        int intx = int.parse(inx!);
        int inty = int.parse(iny!);
        return [intx, inty];
      }

      for (int i = 1; i <= 9; i++) {
        if (i % 2 == 0) {
          String p = "O";
          List<int> pos = turn(p);
          int intx = pos[0];
          int inty = pos[1];
          while (intx == null || inty == null) {
            //corrigir tratamento de erro | adionar <0 ou >2 e possivelmente trasnformar em função
            print("Insira corretamente os valores de linha e coluna!");
            pos = turn(p);
            intx = pos[0];
            inty = pos[1];
          }
          while (tab.tabuleiro[intx][inty] != " ") {
            print("Casa ocupada, escolha outra!");
            pos = turn(p);
            intx = pos[0];
            inty = pos[1];
          }
          tab.alterarTabuleiro(intx, inty, p);
        } else {
          String p = "X";
          List<int> pos = turn(p);
          int intx = pos[0];
          int inty = pos[1];
          while (intx == null || inty == null) {
            print("Insira corretamente os valores de linha e coluna!");
            pos = turn(p);
            intx = pos[0];
            inty = pos[1];
          }
          while (tab.tabuleiro[intx][inty] != " ") {
            print("Casa ocupada, escolha outra!");
            pos = turn(p);
            intx = pos[0];
            inty = pos[1];
          }
          tab.alterarTabuleiro(intx, inty, p);
        }
        gamerun = false;
      }
    }
  }
}

void main() {
  Jogo game = Jogo(true);
  bool run = true;
  while (run == true) {
    print('''

===========================================
Seja bem vindo ao jogo da velha do Schumann
===========================================

Digite 0 para sair ou 1 para jogar:''');
    String? input = stdin.readLineSync();
    if (input == "0") {
      run = false;
    } else {
      game.start();
    }
  }
}

/*TODO:
if tab[x][y] != " "
tratamento de erro
<0 >2 erro
casa ocupada
verificação de vencedor*/
