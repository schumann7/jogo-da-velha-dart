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
  late List<dynamic> tabuleiro;
  late Tabuleiro tab;

  Jogo(bool gamerun, List<dynamic> tabuleiro) {
    this.gamerun = gamerun;
    this.tabuleiro = tabuleiro;
    this.tab = Tabuleiro(tabuleiro);
  }

  void start() {
    gamerun = true;
    while (gamerun) {
      List<int> turn(String p) {
        stdout.writeln();
        print("Turno do $p:");
        tab.printTabuleiro();
        print("Selecione em qual linha você deseja jogar:");
        String? inx = stdin.readLineSync();
        print("Selecione em qual coluna você deseja jogar:");
        String? iny = stdin.readLineSync();
        int intx = int.parse(inx!);
        int inty = int.parse(iny!);
        print("\x1B[2J\x1B[0;0H");
        return [intx, inty];
      }

      for (int i = 1; i <= 9; i++) {
        if (!gamerun) break;

        if (i % 2 == 0) {
          String p = "O";
          List<int> pos = turn(p);
          int intx = pos[0];
          while (intx != 0 && intx != 1 && intx != 2) {
            print("Insira corretamente os valores para a linha!");
            pos = turn(p);
            intx = pos[0];
          }
          int inty = pos[1];
          while (inty != 0 && inty != 1 && inty != 2) {
            print("Insira corretamente os valores para a coluna!");
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
          verificaGanhador(p);
        } else {
          String p = "X";
          List<int> pos = turn(p);
          int intx = pos[0];
          while (intx != 0 && intx != 1 && intx != 2) {
            print("Insira corretamente os valores para a linha!");
            pos = turn(p);
            intx = pos[0];
          }
          int inty = pos[1];
          while (inty != 0 && inty != 1 && inty != 2) {
            print("Insira corretamente os valores para a coluna!");
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
          verificaGanhador(p);
        }

        if (!gamerun) break;
      }

      if (gamerun) {
        tab.printTabuleiro();
        print('''

=============================
          Deu velha!
=============================''');
        print("\x1B[2J\x1B[0;0H");
        gamerun = false;
      }
    }
  }

  void verificaGanhador(p) {
    void printar(p) {
      print('''

=============================
          $p ganhou!
          Parabéns!
=============================''');
      print("\x1B[2J\x1B[0;0H");
      gamerun = false;
    }

    if (tab.tabuleiro[0][0] == p &&
        tab.tabuleiro[0][1] == p &&
        tab.tabuleiro[0][2] == p) {
      printar(p);
    } else if (tab.tabuleiro[1][0] == p &&
        tab.tabuleiro[1][1] == p &&
        tab.tabuleiro[1][2] == p) {
      printar(p);
    } else if (tab.tabuleiro[2][0] == p &&
        tab.tabuleiro[2][1] == p &&
        tab.tabuleiro[2][2] == p) {
      printar(p);
    } else if (tab.tabuleiro[0][0] == p &&
        tab.tabuleiro[1][0] == p &&
        tab.tabuleiro[2][0] == p) {
      printar(p);
    } else if (tab.tabuleiro[0][1] == p &&
        tab.tabuleiro[1][1] == p &&
        tab.tabuleiro[2][1] == p) {
      printar(p);
    } else if (tab.tabuleiro[0][2] == p &&
        tab.tabuleiro[1][2] == p &&
        tab.tabuleiro[2][2] == p) {
      printar(p);
    } else if (tab.tabuleiro[0][0] == p &&
        tab.tabuleiro[1][1] == p &&
        tab.tabuleiro[2][2] == p) {
      printar(p);
    } else if (tab.tabuleiro[0][2] == p &&
        tab.tabuleiro[1][1] == p &&
        tab.tabuleiro[2][0] == p) {
      printar(p);
    }
  }
}

void main() {
  List<dynamic> tabuleiro = [
    [" ", " ", " "],
    [" ", " ", " "],
    [" ", " ", " "],
  ];
  Jogo game = Jogo(true, tabuleiro);
  bool run = true;
  while (run) {
    print('''

===========================================
Seja bem vindo ao jogo da velha do Schumann
===========================================

Digite 0 para sair ou pressione Enter para jogar:''');
    String? input = stdin.readLineSync();
    if (input == "0") {
      run = false;
    } else {
      tabuleiro = [
        [" ", " ", " "],
        [" ", " ", " "],
        [" ", " ", " "],
      ];
      game = Jogo(true, tabuleiro);
      game.start();
    }
  }
}
