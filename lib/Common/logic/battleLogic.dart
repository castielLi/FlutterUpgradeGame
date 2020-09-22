import 'package:upgradegame/Common/logic/model/baseSoldierModel.dart';
import 'package:upgradegame/Common/logic/model/hunterModel.dart';
import 'package:upgradegame/Common/logic/model/knightModel.dart';
import 'package:upgradegame/Common/logic/model/noSoldierModel.dart';
import 'package:upgradegame/Common/logic/model/warriorModel.dart';

class BattleLogic {
  List<List<BaseSoldierModel>> mine;
  List<List<BaseSoldierModel>> enemy;
  List<List<BaseSoldierModel>> battleGround;
  int mineCount = 0;
  int enemyCount = 0;
  int times = 0;

  BattleLogic({this.mine, this.enemy});

  /// 先通过行动值的高低来进行判断，讲所有行动值高的角色先行
  void prepareBattle() {
    ///初始化战场容器
    for (int i = 0; i < 4; i++) {
      List<BaseSoldierModel> row = [];
      for (int j = 0; j < 6; j++) {
        row.add(new NoSoldierModel(0, 0));
      }
      battleGround.add(row);
    }

    ///添加我的阵容到战场容器中
    for (int i = 0; i < mine.length; i++) {
      for (int j = 0; j < mine[i].length; j++) {
        if (mine[i][j] is NoSoldierModel) {
          continue;
        } else {
          battleGround[i][j] = mine[i][j];
          mineCount += 1;
        }
      }
    }

    ///添加敌方阵容到战场容器
    for (int i = 0; i < enemy.length; i++) {
      for (int j = 0; j < enemy.length; j++) {
        if (enemy[i][j] is NoSoldierModel) {
          continue;
        } else {
          battleGround[i][j + 2] = enemy[i][j];
          enemyCount += 1;
        }
      }
    }
  }

  void startBattle() {
    ///骑士判断
    for (int i = 0; i < battleGround.length; i++) {
      for (int j = 0; j < battleGround[i].length; j++) {
        if (battleGround[i][j] is KnightModel) {
          KnightModel soldier = battleGround[i][j];

          ///我的士兵
          if (soldier.mine) {
            ///主动攻击
            ///判断上下左右是否有敌方的士兵

            ///判断是否已经攻击
            int attack = 0;

            ///右
            if (j + 1 <= 5) {
              if (battleGround[i][j + 1] is NoSoldierModel) {
                continue;
              } else {
                attack += 1;
                if (!battleGround[i][j + 1].mine) {
                  if (battleGround[i][j + 1] is WarriorModel) {
                    battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else if (battleGround[i][j + 1] is HunterModel) {
                    battleGround[i][j + 1].blood -= 1;
                    if (battleGround[i][j + 1].blood <= 0) {
                      battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  } else {
                    battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  }
                }
              }
            }

            ///上
            if (soldier.blood > 0 && attack == 0) {
              if (i - 1 >= 0) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[i - 1][j].mine) {
                    if (battleGround[i - 1][j] is WarriorModel) {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else if (battleGround[i - 1][j] is HunterModel) {
                      battleGround[i - 1][j].blood -= 1;
                      if (battleGround[i - 1][j].blood <= 0) {
                        battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    } else {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///下
            if (soldier.blood > 0 && attack == 0) {
              if (i + 1 <= 3) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[i + 1][j].mine) {
                    if (battleGround[i + 1][j] is WarriorModel) {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else if (battleGround[i + 1][j] is HunterModel) {
                      battleGround[i + 1][j].blood -= 1;
                      if (battleGround[i + 1][j].blood <= 0) {
                        battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    } else {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///左
            if (soldier.blood > 0 && attack == 0) {
              if (j - 1 >= 0) {
                if (battleGround[i][j - 1] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[1][j - 1].mine) {
                    if (battleGround[i][j - 1] is WarriorModel) {
                      battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else if (battleGround[i][j - 1] is HunterModel) {
                      battleGround[i][j - 1].blood -= 1;
                      if (battleGround[i][j - 1].blood <= 0) {
                        battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    } else {
                      battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }
          } else {
            ///不是我的士兵
            ///左
            ///

            ///判断是否已经攻击
            int attack = 0;

            if (j - 1 >= 0) {
              if (battleGround[i][j - 1] is NoSoldierModel) {
                continue;
              } else {
                attack += 1;
                if (battleGround[i][j - 1].mine) {
                  if (battleGround[i][j - 1] is WarriorModel) {
                    battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                    mineCount -= 1;
                  } else if (battleGround[i][j - 1] is HunterModel) {
                    battleGround[i][j - 1].blood -= 1;
                    if (battleGround[i][j - 1].blood <= 0) {
                      battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    }
                  } else {
                    battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  }
                }
              }
            }

            ///上
            if (soldier.blood > 0 && attack == 0) {
              if (i - 1 >= 0) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i - 1][j].mine) {
                    if (battleGround[i - 1][j] is WarriorModel) {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    } else if (battleGround[i - 1][j] is HunterModel) {
                      battleGround[i - 1][j].blood -= 1;
                      if (battleGround[i - 1][j].blood <= 0) {
                        battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                        mineCount -= 1;
                      }
                    } else {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///下
            if (soldier.blood > 0 && attack == 0) {
              if (i + 1 <= 3) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i + 1][j].mine) {
                    if (battleGround[i + 1][j] is WarriorModel) {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    } else if (battleGround[i + 1][j] is HunterModel) {
                      battleGround[i + 1][j].blood -= 1;
                      if (battleGround[i + 1][j].blood <= 0) {
                        battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                        mineCount -= 1;
                      }
                    } else {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///右
            if (soldier.blood > 0 && attack == 0) {
              if (j + 1 <= 3) {
                if (battleGround[i][j + 1] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[1][j + 1].mine) {
                    if (battleGround[i][j + 1] is WarriorModel) {
                      battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    } else if (battleGround[i][j + 1] is HunterModel) {
                      battleGround[i][j + 1].blood -= 1;
                      if (battleGround[i][j + 1].blood <= 0) {
                        battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                        mineCount -= 1;
                      }
                    } else {
                      battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    ///战士判断
    for (int i = 0; i < battleGround.length; i++) {
      for (int j = 0; j < battleGround[i].length; j++) {
        if (battleGround[i][j] is WarriorModel) {
          WarriorModel soldier = battleGround[i][j];

          ///我的士兵
          if (soldier.mine) {
            ///主动攻击
            ///判断上下左右是否有敌方的士兵

            int attack = 0;

            ///右
            if (j + 1 <= 5) {
              if (battleGround[i][j + 1] is NoSoldierModel) {
                continue;
              } else {
                attack += 1;
                if (!battleGround[i][j + 1].mine) {
                  if (battleGround[i][j + 1] is WarriorModel) {
                    battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 1] is HunterModel) {
                    battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 1].blood -= 1;
                    if (battleGround[i][j + 1].blood <= 0) {
                      battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }
              }
            }

            ///左
            if (soldier.blood > 0 && attack == 0) {
              if (j - 1 >= 0) {
                if (battleGround[i][j - 1] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[1][j - 1].mine) {
                    if (battleGround[i][j - 1] is WarriorModel) {
                      battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    } else if (battleGround[i][j - 1] is KnightModel) {
                      battleGround[i][j - 1].blood -= 1;
                      if (battleGround[i][j - 1].blood <= 0) {
                        battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    } else {
                      battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }
              }
            }

            ///上
            if (soldier.blood > 0 && attack == 0) {
              if (i - 1 >= 0) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[i - 1][j].mine) {
                    if (battleGround[i - 1][j] is HunterModel) {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else if (battleGround[i - 1][j] is KnightModel) {
                      battleGround[i - 1][j].blood -= 1;
                      if (battleGround[i - 1][j].blood <= 0) {
                        battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    } else {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///下
            if (soldier.blood > 0 && attack == 0) {
              if (i + 1 <= 3) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[i + 1][j].mine) {
                    if (battleGround[i + 1][j] is HunterModel) {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else if (battleGround[i + 1][j] is KnightModel) {
                      battleGround[i + 1][j].blood -= 1;
                      if (battleGround[i + 1][j].blood <= 0) {
                        battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    } else {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }
          } else {
            ///不是我的士兵
            ///左
            ///

            int attack = 0;

            if (j - 1 >= 0) {
              if (battleGround[i][j - 1] is NoSoldierModel) {
                continue;
              } else {
                attack += 1;
                if (battleGround[i][j - 1].mine) {
                  if (battleGround[i][j - 1] is HunterModel) {
                    battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                    mineCount -= 1;
                  } else if (battleGround[i][j - 1] is KnightModel) {
                    battleGround[i][j - 1].blood -= 1;
                    if (battleGround[i][j - 1].blood <= 0) {
                      battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    }
                  } else {
                    battleGround[i][j - 1] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  }
                }
              }
            }

            ///上
            if (soldier.blood > 0 && attack == 0) {
              if (i - 1 >= 0) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i - 1][j].mine) {
                    if (battleGround[i - 1][j] is HunterModel) {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    } else if (battleGround[i - 1][j] is KnightModel) {
                      battleGround[i - 1][j].blood -= 1;
                      if (battleGround[i - 1][j].blood <= 0) {
                        battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                        mineCount -= 1;
                      }
                    } else {
                      battleGround[i - 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///下
            if (soldier.blood > 0 && attack == 0) {
              if (i + 1 <= 3) {
                if (battleGround[i - 1][j] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i + 1][j].mine) {
                    if (battleGround[i + 1][j] is HunterModel) {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    } else if (battleGround[i + 1][j] is KnightModel) {
                      battleGround[i + 1][j].blood -= 1;
                      if (battleGround[i + 1][j].blood <= 0) {
                        battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                        mineCount -= 1;
                      }
                    } else {
                      battleGround[i + 1][j] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }

            ///右
            if (soldier.blood > 0 && attack == 0) {
              if (j + 1 <= 3) {
                if (battleGround[i][j + 1] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (!battleGround[1][j + 1].mine) {
                    if (battleGround[i][j + 1] is HunterModel) {
                      battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                      mineCount -= 1;
                    } else if (battleGround[i][j + 1] is KnightModel) {
                      battleGround[i][j + 1].blood -= 1;
                      if (battleGround[i][j + 1].blood <= 0) {
                        battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                        mineCount -= 1;
                      }
                    } else {
                      battleGround[i][j + 1] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    ///弓手判断
    ///todo:lizongjun  逻辑还需要更改
    for (int i = 0; i < battleGround.length; i++) {
      for (int j = 0; j < battleGround[i].length; j++) {
        if (battleGround[i][j] is HunterModel) {
          HunterModel soldier = battleGround[i][j];
          if (soldier.mine) {
            ///主动进攻
            ///
            int attack = 0;

            ///面前的不能攻击,隔一个格子前面三个格子区域攻击

            ///右
            if (j + 2 <= 5) {
              ///第一格
              if (battleGround[i][j + 2] is NoSoldierModel) {
                continue;
              } else {
                attack += 1;
                if (battleGround[i][j + 2] is HunterModel) {
                  battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                  battleGround[i][j] = new NoSoldierModel(0, 0);
                  enemyCount -= 1;
                  mineCount -= 1;
                } else if (battleGround[i][j + 2] is KnightModel) {
                  battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                  enemyCount -= 1;
                } else {
                  battleGround[i][j + 2].blood -= 1;
                  if (battleGround[i][j + 2].blood <= 0) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  }
                }
              }

              ///第二格
              if (attack == 0) {
                if (i - 1 >= 0) {
                  if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                    continue;
                  } else {
                    attack += 1;
                    if (battleGround[i - 1][j + 2] is HunterModel) {
                      battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    } else if (battleGround[i - 1][j + 2] is KnightModel) {
                      battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else {
                      battleGround[i - 1][j + 2].blood -= 1;
                      if (battleGround[i - 1][j + 2].blood <= 0) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    }
                  }
                }
              }

              ///第三格
              if (attack == 0) {
                if (i + 1 <= 3) {
                  if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                    continue;
                  } else {
                    attack += 1;
                    if (battleGround[i + 1][j + 2] is HunterModel) {
                      battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    } else if (battleGround[i + 1][j + 2] is KnightModel) {
                      battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else {
                      battleGround[i + 1][j + 2].blood -= 1;
                      if (battleGround[i + 1][j + 2].blood <= 0) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    }
                  }
                }
              }
            }

            ///左
            if (j - 2 >= 5) {
              if (attack == 0) {
                ///第一格
                if (battleGround[i][j + 2] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i][j + 2] is HunterModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 2] is KnightModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 2].blood -= 1;
                    if (battleGround[i][j + 2].blood <= 0) {
                      battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }

                ///第二格
                if (attack == 0) {
                  if (i - 1 >= 0) {
                    if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i - 1][j + 2] is HunterModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i - 1][j + 2] is KnightModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i - 1][j + 2].blood -= 1;
                        if (battleGround[i - 1][j + 2].blood <= 0) {
                          battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }

                ///第三格
                if (attack == 0) {
                  if (i + 1 <= 3) {
                    if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i + 1][j + 2] is HunterModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i + 1][j + 2] is KnightModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i + 1][j + 2].blood -= 1;
                        if (battleGround[i + 1][j + 2].blood <= 0) {
                          battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }
              }
            }

            ///上
            if (i - 2 >= 0) {
              if (attack == 0) {
                ///第一格
                if (battleGround[i][j + 2] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i][j + 2] is HunterModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 2] is KnightModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 2].blood -= 1;
                    if (battleGround[i][j + 2].blood <= 0) {
                      battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }

                ///第二格
                if (attack == 0) {
                  if (i - 1 >= 0) {
                    if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i - 1][j + 2] is HunterModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i - 1][j + 2] is KnightModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i - 1][j + 2].blood -= 1;
                        if (battleGround[i - 1][j + 2].blood <= 0) {
                          battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }

                ///第三格
                if (attack == 0) {
                  if (i + 1 <= 3) {
                    if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i + 1][j + 2] is HunterModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i + 1][j + 2] is KnightModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i + 1][j + 2].blood -= 1;
                        if (battleGround[i + 1][j + 2].blood <= 0) {
                          battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }
              }
            }

            ///下
            if (i + 2 <= 3) {
              if (attack == 0) {
                ///第一格
                if (battleGround[i][j + 2] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i][j + 2] is HunterModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 2] is KnightModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 2].blood -= 1;
                    if (battleGround[i][j + 2].blood <= 0) {
                      battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }

                ///第二格
                if (attack == 0) {
                  if (i - 1 >= 0) {
                    if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i - 1][j + 2] is HunterModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i - 1][j + 2] is KnightModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i - 1][j + 2].blood -= 1;
                        if (battleGround[i - 1][j + 2].blood <= 0) {
                          battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }

                ///第三格
                if (attack == 0) {
                  if (i + 1 <= 3) {
                    if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i + 1][j + 2] is HunterModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i + 1][j + 2] is KnightModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i + 1][j + 2].blood -= 1;
                        if (battleGround[i + 1][j + 2].blood <= 0) {
                          battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }
              }
            }
          } else {
            int attack = 0;

            ///面前的不能攻击,隔一个格子前面三个格子区域攻击

            ///右
            if (j + 2 <= 5) {
              ///第一格
              if (battleGround[i][j + 2] is NoSoldierModel) {
                continue;
              } else {
                attack += 1;
                if (battleGround[i][j + 2] is HunterModel) {
                  battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                  battleGround[i][j] = new NoSoldierModel(0, 0);
                  enemyCount -= 1;
                  mineCount -= 1;
                } else if (battleGround[i][j + 2] is KnightModel) {
                  battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                  enemyCount -= 1;
                } else {
                  battleGround[i][j + 2].blood -= 1;
                  if (battleGround[i][j + 2].blood <= 0) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  }
                }
              }

              ///第二格
              if (attack == 0) {
                if (i - 1 >= 0) {
                  if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                    continue;
                  } else {
                    attack += 1;
                    if (battleGround[i - 1][j + 2] is HunterModel) {
                      battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    } else if (battleGround[i - 1][j + 2] is KnightModel) {
                      battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else {
                      battleGround[i - 1][j + 2].blood -= 1;
                      if (battleGround[i - 1][j + 2].blood <= 0) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    }
                  }
                }
              }

              ///第三格
              if (attack == 0) {
                if (i + 1 <= 3) {
                  if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                    continue;
                  } else {
                    attack += 1;
                    if (battleGround[i + 1][j + 2] is HunterModel) {
                      battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                      battleGround[i][j] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                      mineCount -= 1;
                    } else if (battleGround[i + 1][j + 2] is KnightModel) {
                      battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    } else {
                      battleGround[i + 1][j + 2].blood -= 1;
                      if (battleGround[i + 1][j + 2].blood <= 0) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      }
                    }
                  }
                }
              }
            }

            ///左
            if (j - 2 >= 5) {
              if (attack == 0) {
                ///第一格
                if (battleGround[i][j + 2] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i][j + 2] is HunterModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 2] is KnightModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 2].blood -= 1;
                    if (battleGround[i][j + 2].blood <= 0) {
                      battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }

                ///第二格
                if (attack == 0) {
                  if (i - 1 >= 0) {
                    if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i - 1][j + 2] is HunterModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i - 1][j + 2] is KnightModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i - 1][j + 2].blood -= 1;
                        if (battleGround[i - 1][j + 2].blood <= 0) {
                          battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }

                ///第三格
                if (attack == 0) {
                  if (i + 1 <= 3) {
                    if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i + 1][j + 2] is HunterModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i + 1][j + 2] is KnightModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i + 1][j + 2].blood -= 1;
                        if (battleGround[i + 1][j + 2].blood <= 0) {
                          battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }
              }
            }

            ///上
            if (i - 2 >= 0) {
              if (attack == 0) {
                ///第一格
                if (battleGround[i][j + 2] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i][j + 2] is HunterModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 2] is KnightModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 2].blood -= 1;
                    if (battleGround[i][j + 2].blood <= 0) {
                      battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }

                ///第二格
                if (attack == 0) {
                  if (i - 1 >= 0) {
                    if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i - 1][j + 2] is HunterModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i - 1][j + 2] is KnightModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i - 1][j + 2].blood -= 1;
                        if (battleGround[i - 1][j + 2].blood <= 0) {
                          battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }

                ///第三格
                if (attack == 0) {
                  if (i + 1 <= 3) {
                    if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i + 1][j + 2] is HunterModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i + 1][j + 2] is KnightModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i + 1][j + 2].blood -= 1;
                        if (battleGround[i + 1][j + 2].blood <= 0) {
                          battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }
              }
            }

            ///下
            if (i + 2 <= 3) {
              if (attack == 0) {
                ///第一格
                if (battleGround[i][j + 2] is NoSoldierModel) {
                  continue;
                } else {
                  attack += 1;
                  if (battleGround[i][j + 2] is HunterModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    battleGround[i][j] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                    mineCount -= 1;
                  } else if (battleGround[i][j + 2] is KnightModel) {
                    battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                    enemyCount -= 1;
                  } else {
                    battleGround[i][j + 2].blood -= 1;
                    if (battleGround[i][j + 2].blood <= 0) {
                      battleGround[i][j + 2] = new NoSoldierModel(0, 0);
                      enemyCount -= 1;
                    }
                  }
                }

                ///第二格
                if (attack == 0) {
                  if (i - 1 >= 0) {
                    if (battleGround[i - 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i - 1][j + 2] is HunterModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i - 1][j + 2] is KnightModel) {
                        battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i - 1][j + 2].blood -= 1;
                        if (battleGround[i - 1][j + 2].blood <= 0) {
                          battleGround[i - 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }

                ///第三格
                if (attack == 0) {
                  if (i + 1 <= 3) {
                    if (battleGround[i + 1][j + 2] is NoSoldierModel) {
                      continue;
                    } else {
                      attack += 1;
                      if (battleGround[i + 1][j + 2] is HunterModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        battleGround[i][j] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                        mineCount -= 1;
                      } else if (battleGround[i + 1][j + 2] is KnightModel) {
                        battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                        enemyCount -= 1;
                      } else {
                        battleGround[i + 1][j + 2].blood -= 1;
                        if (battleGround[i + 1][j + 2].blood <= 0) {
                          battleGround[i + 1][j + 2] = new NoSoldierModel(0, 0);
                          enemyCount -= 1;
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    if (mineCount > 0 && enemyCount <= 0) {
      print("我赢了");
    } else if (mineCount <= 0 && enemyCount > 0) {
      print("敌人赢了");
    } else if (mineCount == 0 && enemyCount == 0) {
      print("平局");
    } else {
      if (times == 2) {
        if (mineCount > enemyCount) {
          print("我赢了");
        } else if (mineCount < enemyCount) {
          print("敌人赢了");
        } else {
          print("平局");
        }
        times = 0;
      } else {
        autoMove();
      }
    }
  }

  void autoMove() {
    ///自动寻路
    ///骑士寻路
    for (int i = 0; i < battleGround.length; i++) {
      for (int j = 0; j < battleGround[i].length; j++) {}
    }

    ///战士寻路
    for (int i = 0; i < battleGround.length; i++) {
      for (int j = 0; j < battleGround[i].length; j++) {}
    }

    ///弓手寻路
    for (int i = 0; i < battleGround.length; i++) {
      for (int j = 0; j < battleGround[i].length; j++) {}
    }

    times += 1;
    startBattle();
  }
}
