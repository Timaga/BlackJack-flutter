import 'dart:math';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class BlackJackScreen extends StatefulWidget {
  @override
  State<BlackJackScreen> createState() => _BlackJackScreenState();
}

class _BlackJackScreenState extends State<BlackJackScreen> {
  bool IsGameStarted = false;
  bool IsGamePassed = false;
  final Map<String, int> deckOfCards = {
    "cards/2.1.png": 2,
    "cards/2.2.png": 2,
    "cards/2.3.png": 2,
    "cards/2.4.png": 2,
    "cards/3.1.png": 3,
    "cards/3.2.png": 3,
    "cards/3.3.png": 3,
    "cards/3.4.png": 3,
    "cards/4.1.png": 4,
    "cards/4.2.png": 4,
    "cards/4.3.png": 4,
    "cards/4.4.png": 4,
    "cards/5.1.png": 5,
    "cards/5.2.png": 5,
    "cards/5.3.png": 5,
    "cards/5.4.png": 5,
    "cards/6.1.png": 6,
    "cards/6.2.png": 6,
    "cards/6.3.png": 6,
    "cards/6.4.png": 6,
    "cards/7.1.png": 7,
    "cards/7.2.png": 7,
    "cards/7.3.png": 7,
    "cards/7.4.png": 7,
    "cards/8.1.png": 8,
    "cards/8.2.png": 8,
    "cards/8.3.png": 8,
    "cards/8.4.png": 8,
    "cards/9.1.png": 9,
    "cards/9.2.png": 9,
    "cards/9.3.png": 9,
    "cards/9.4.png": 9,
    "cards/10.1.png": 10,
    "cards/10.2.png": 10,
    "cards/10.3.png": 10,
    "cards/10.4.png": 10,
    "cards/J1.png": 10,
    "cards/J2.png": 10,
    "cards/J3.png": 10,
    "cards/J4.png": 10,
    "cards/Q1.png": 10,
    "cards/Q2.png": 10,
    "cards/Q3.png": 10,
    "cards/Q4.png": 10,
    "cards/K1.png": 10,
    "cards/K2.png": 10,
    "cards/K3.png": 10,
    "cards/K4.png": 10,
    "cards/A1.png": 11,
    "cards/A2.png": 11,
    "cards/A3.png": 11,
    "cards/A4.png": 11,
  };

  bool GameIsEnded = false;
  bool results = false;
  List<Image> myCards = [];
  List<Image> dealersCards = [];
  Map<String, int> playingCards = {};

  String? dealersFirstCard;
  String? playerFirstCard;

  String? dealersSecondCard;
  String? playerSecondCard;

  int playerScore = 0;
  int dealerScore = 0;

  void changeCards() {
    setState(() {
      IsGameStarted = true;
      IsGamePassed = false;
      GameIsEnded = false;
    });
    myCards = [];
    dealersCards = [];

    playingCards = {};

    playingCards.addAll(deckOfCards);

    Random random = Random();
    String cardOneKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));

    playingCards.removeWhere((key, value) => key == cardOneKey);

    String cardTwoKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardTwoKey);

    String cardThreeKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardThreeKey);

    String cardFourKey =
        playingCards.keys.elementAt(random.nextInt(playingCards.length));
    playingCards.removeWhere((key, value) => key == cardFourKey);

    dealersFirstCard = cardOneKey;
    playerFirstCard = cardThreeKey;
    dealersSecondCard = cardTwoKey;
    playerSecondCard = cardFourKey;

    dealersCards.add(Image.asset(dealersFirstCard!));
    dealersCards.add(Image.asset(dealersSecondCard!));

    dealerScore =
        deckOfCards[dealersFirstCard]! + deckOfCards[dealersSecondCard]!;

    myCards.add(Image.asset(playerFirstCard!));
    myCards.add(Image.asset(playerSecondCard!));
    playerScore =
        deckOfCards[playerFirstCard]! + deckOfCards[playerSecondCard]!;
  }

  void ShowAlertQuit() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: 'Do you want to exit?',
      confirmBtnText: 'Yes',
      onConfirmBtnTap: () => setState(() {
        GameIsEnded = false;
        IsGameStarted = false;
        IsGamePassed = false;
        Navigator.of(context).pop();
      }),
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
    );
  }

  Future<void> ShowAlertWin() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You are win! Congratulations!"),
            content: Text("Do you wish to continue?"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    changeCards();
                  },
                  child: Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      GameIsEnded = false;
                      IsGameStarted = false;
                      IsGamePassed = false;
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  Future<void> ShowAlertLose() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("You are Lose! =<"),
            content: Text("Do you wish to continue?"),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    changeCards();
                  },
                  child: Text("Yes")),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      GameIsEnded = false;
                      IsGameStarted = false;
                      IsGamePassed = false;
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text("No"))
            ],
          );
        });
  }

  void AddCard() {
    Random random = Random();
    if (IsGamePassed == false) {
      if (playerScore < 21 && dealerScore < 21) {
        String cardNewKey =
            playingCards.keys.elementAt(random.nextInt(playingCards.length));

        playingCards.removeWhere((key, value) => key == cardNewKey);
        setState(() {
          myCards.add(Image.asset(cardNewKey!));
          playerScore = playerScore + deckOfCards[cardNewKey]!;
        });
      }
      Future.delayed(Duration(seconds: 1), () {
        if (playerScore == 21 && GameIsEnded == false ||
            playerScore < 21 && dealerScore > 21 && GameIsEnded == false) {
          GameIsEnded = true;
          ShowAlertWin();
        } else if (playerScore > 21 && GameIsEnded == false ||
            dealerScore == 21 && GameIsEnded == false) {
          GameIsEnded = true;
          ShowAlertLose();
        }
        if (dealerScore <= 16 && playerScore < 21 && GameIsEnded == false) {
          String cardNewDealerKey =
              playingCards.keys.elementAt(random.nextInt(playingCards.length));

          playingCards.removeWhere((key, value) => key == cardNewDealerKey);
          setState(() {
            dealersCards.add(Image.asset(cardNewDealerKey!));
            dealerScore = dealerScore + deckOfCards[cardNewDealerKey]!;
          });
        } else if (dealerScore > 21 &&
            playerScore < 21 &&
            GameIsEnded == false) {
          GameIsEnded = true;
          ShowAlertWin();
        } else if (dealerScore == 21 &&
            playerScore < 21 &&
            GameIsEnded == false) {
          GameIsEnded = true;
          ShowAlertLose();
        } else if (dealerScore == 21 &&
            playerScore == 21 &&
            GameIsEnded == false) {
          GameIsEnded = true;
          ShowAlertLose();
        }
      });
    }
  }

  void GamePassed() {
    Random random = Random();
    while (dealerScore <= 16 && playerScore < 21) {
      if (dealerScore <= 16 && playerScore < 21) {
        String cardNewDealerKey =
            playingCards.keys.elementAt(random.nextInt(playingCards.length));

        playingCards.removeWhere((key, value) => key == cardNewDealerKey);
        setState(() {
          dealersCards.add(Image.asset(cardNewDealerKey!));
          dealerScore = dealerScore + deckOfCards[cardNewDealerKey]!;
        });
      }
    }
    Future.delayed(Duration(seconds: 1), () {
      if (dealerScore > 21 && playerScore < 21 && GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertWin();
      } else if (dealerScore == 21 &&
          playerScore < 21 &&
          GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertLose();
      } else if (dealerScore > 16 &&
          playerScore > dealerScore &&
          playerScore < 21 &&
          dealerScore < 21 &&
          GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertWin();
      } else if (dealerScore > 16 &&
          playerScore < dealerScore &&
          playerScore < 21 &&
          dealerScore < 21 &&
          GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertLose();
      } else if (playerScore == 21 && GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertWin();
      } else if (playerScore > 21 && GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertLose();
      } else if (playerScore == dealerScore && GameIsEnded == false) {
        GameIsEnded = true;
        ShowAlertLose();
      }
    });
  }

  @override
  void initState() {
    playingCards.addAll(deckOfCards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IsGameStarted
          ? SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            onPressed: ShowAlertQuit,
                            icon: Icon(Icons.arrow_back),
                          ),
                        ),
                        Text(
                          "Dealer Score $dealerScore",
                          style: TextStyle(
                              color: dealerScore <= 21
                                  ? Colors.green[500]
                                  : Colors.red),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200,
                          child: GridView.builder(
                              itemCount: dealersCards.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return dealersCards[index];
                              }),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Your Score $playerScore",
                          style: TextStyle(
                              color: playerScore <= 21
                                  ? Colors.green[500]
                                  : Colors.red),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 200,
                          child: GridView.builder(
                              itemCount: myCards.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, index) {
                                return myCards[index];
                              }),
                        ),
                      ],
                    ),
                    Expanded(
                      child: IntrinsicWidth(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              child: Text(
                                "Add card",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple[200],
                              ),
                              onPressed: () {
                                AddCard();
                              },
                            ),
                            ElevatedButton(
                              child: Text(
                                "Pass",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple[200],
                              ),
                              onPressed: () {
                                IsGamePassed = true;
                                GamePassed();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Center(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("cards/3.gif"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            changeCards();
                          },
                          child: Text("Start Game"),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
