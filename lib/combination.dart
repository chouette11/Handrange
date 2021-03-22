import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handrange/light.dart';
import 'package:provider/provider.dart';
const CONBI =[{
  "hand": 'AA',
  "value":6,
},
  {
    "hand": 'AKs',
    "value":4,
  },
  {
    "hand": 'AQs',
    "value":4,
  },{
    "hand": 'AJs',
    "value":4,
  },{
    "hand": 'ATs',
    "value":4,
  },{
    "hand": 'A9s',
    "value":4,
  },{
    "hand": 'A8s',
    "value":4,
  },{
    "hand": 'A7s',
    "value":4,
  },{
    "hand": 'A6s',
    "value":4,
  },{
    "hand": 'A5s',
    "value":4,
  },{
    "hand": 'A4s',
    "value":4,
  },{
    "hand": 'A3s',
    "value":4,
  },{
    "hand": 'A2s',
    "value":4,
  },{
    "hand": 'AKo',
    "value":12,
  },{
    "hand": 'KK',
    "value":6,
  },{
    "hand": 'KQs',
    "value":4,
  },{
    "hand": 'KJs',
    "value":4,
  },{
    "hand": 'KTs',
    "value":4,
  },{
    "hand": 'K9s',
    "value":4,
  },{
    "hand": 'K8s',
    "value":4,
  },{
    "hand": 'K7s',
    "value":4,
  },{
    "hand": 'K6s',
    "value":4,
  },{
    "hand": 'K5s',
    "value":4,
  },{
    "hand": 'K4s',
    "value":4,
  },{
    "hand": 'K3s',
    "value":4,
  },{
    "hand": 'K2s',
    "value":4,
  },{
    "hand": 'AQo',
    "value":12,
  },{
    "hand": 'KQo',
    "value":12,
  },{
    "hand": 'QQ',
    "value":6,
  },{
    "hand": 'QJs',
    "value":4,
  },{
    "hand": 'QTs',
    "value":4,
  },{
    "hand": 'Q9s',
    "value":4,
  },{
    "hand": 'Q8s',
    "value":4,
  },{
    "hand": 'Q7s',
    "value":4,
  },{
    "hand": 'Q6s',
    "value":4,
  },{
    "hand": 'Q5s',
    "value":4,
  },{
    "hand": 'Q4s',
    "value":4,
  },{
    "hand": 'Q3s',
    "value":4,
  },{
    "hand": 'Q2s',
    "value":4,
  },{
    "hand": 'AJo',
    "value":12,
  },{
    "hand": 'KJo',
    "value":12,
  },{
    "hand": 'QJo',
    "value":12,
  },{
    "hand": 'JJ',
    "value":6,
  },{
    "hand": 'JTs',
    "value":4,
  },{
    "hand": 'J9s',
    "value":4,
  },{
    "hand": 'J8s',
    "value":4,
  },{
    "hand": 'J7s',
    "value":4,
  },{
    "hand": 'J6s',
    "value":4,
  },{
    "hand": 'J5s',
    "value":4,
  },{
    "hand": 'J4s',
    "value":4,
  },{
    "hand": 'J3s',
    "value":4,
  },{
    "hand": 'J2s',
    "value":4,
  },{
    "hand": 'ATo',
    "value":12,
  },{
    "hand": 'KTo',
    "value":12,
  },{
    "hand": 'QTo',
    "value":12,
  },{
    "hand": 'JTo',
    "value":12,
  },{
    "hand": 'TT',
    "value":6,
  },{
    "hand": 'T9s',
    "value":4,
  },{
    "hand": 'T8s',
    "value":4,
  },{
    "hand": 'T7s',
    "value":4,
  },{
    "hand": 'T6s',
    "value":4,
  },{
    "hand": 'T5s',
    "value":4,
  },{
    "hand": 'T4s',
    "value":4,
  },{
    "hand": 'T3s',
    "value":4,
  },{
    "hand": 'T2s',
    "value":4,
  },{
    "hand": 'A9o',
    "value":12,
  },{
    "hand": 'K9o',
    "value":12,
  },{
    "hand": 'Q9o',
    "value":12,
  },{
    "hand": 'J9o',
    "value":12,
  },{
    "hand": 'T9o',
    "value":12,
  },{
    "hand": '99',
    "value":6,
  },{
    "hand": '98s',
    "value":4,
  },{
    "hand": '97s',
    "value":4,
  },{
    "hand": '96s',
    "value":4,
  },{
    "hand": '95s',
    "value":4,
  },{
    "hand": '94s',
    "value":4,
  },{
    "hand": '93s',
    "value":4,
  },{
    "hand": '92s',
    "value":4,
  },{
    "hand": 'A8o',
    "value":12,
  },{
    "hand": 'K8o',
    "value":12,
  },{
    "hand": 'Q8o',
    "value":12,
  },{
    "hand": 'J8o',
    "value":12,
  },{
    "hand": 'T8o',
    "value":12,
  },{
    "hand": '98o',
    "value":12,
  },{
    "hand": '88',
    "value":6,
  },{
    "hand": '87s',
    "value":4,
  },{
    "hand": '86s',
    "value":4,
  },{
    "hand": '85s',
    "value":4,
  },{
    "hand": '84s',
    "value":4,
  },{
    "hand": '83s',
    "value":4,
  },{
    "hand": '82s',
    "value":4,
  },{
    "hand": 'A7o',
    "value":12,
  },{
    "hand": 'K7o',
    "value":12,
  },{
    "hand": 'Q7o',
    "value":12,
  },{
    "hand": 'J7o',
    "value":12,
  },{
    "hand": 'T7o',
    "value":12,
  },{
    "hand": '97o',
    "value":12,
  },{
    "hand": '87o',
    "value":12,
  },{
    "hand": '77',
    "value":6,
  },{
    "hand": '76s',
    "value":6,
  },{
    "hand": '75s',
    "value":4,
  },{
    "hand": '74s',
    "value":4,
  },{
    "hand": '73s',
    "value":4,
  },{
    "hand": '72s',
    "value":4,
  },{
    "hand": 'A6o',
    "value":12,
  },{
    "hand": 'K6o',
    "value":12,
  },{
    "hand": 'Q6o',
    "value":12,
  },{
    "hand": 'J6o',
    "value":12,
  },{
    "hand": 'T6o',
    "value":12,
  },{
    "hand": '96o',
    "value":12,
  },{
    "hand": '86o',
    "value":12,
  },{
    "hand": '76o',
    "value":12,
  },{
    "hand": '66',
    "value":6,
  },{
    "hand": '65s',
    "value":4,
  },{
    "hand": '64s',
    "value":4,
  },{
    "hand": '63s',
    "value":4,
  },{
    "hand": '62s',
    "value":4,
  },{
    "hand": 'A5o',
    "value":12,
  },{
    "hand": 'K5o',
    "value":12,
  },{
    "hand": 'Q5o',
    "value":12,
  },{
    "hand": 'J5o',
    "value":12,
  },{
    "hand": 'T5o',
    "value":12,
  },{
    "hand": '95o',
    "value":12,
  },{
    "hand": '85o',
    "value":12,
  },{
    "hand": '75o',
    "value":12,
  },{
    "hand": '65o',
    "value":12,
  },{
    "hand": '55',
    "value":6,
  },{
    "hand": '54s',
    "value":4,
  },{
    "hand": '53s',
    "value":4,
  },{
    "hand": '52s',
    "value":4,
  },{
    "hand": 'A4o',
    "value":12,
  },{
    "hand": 'K4o',
    "value":12,
  },{
    "hand": 'Q4o',
    "value":12,
  },{
    "hand": 'J4o',
    "value":12,
  },{
    "hand": 'T4o',
    "value":12,
  },{
    "hand": '94o',
    "value":12,
  },{
    "hand": '84o',
    "value":12,
  },{
    "hand": '74o',
    "value":12,
  },{
    "hand": '64o',
    "value":12,
  },{
    "hand": '54o',
    "value":12,
  },{
    "hand": '44',
    "value":6,
  },{
    "hand": '43s',
    "value":4,
  },{
    "hand": '42s',
    "value":4,
  },{
    "hand": 'A3o',
    "value":12,
  },{
    "hand": 'K3o',
    "value":12,
  },{
    "hand": 'Q3o',
    "value":12,
  },{
    "hand": 'J3o',
    "value":12,
  },{
    "hand": 'T3o',
    "value":12,
  },{
    "hand": '93o',
    "value":12,
  },{
    "hand": '83o',
    "value":12,
  },{
    "hand": '73o',
    "value":12,
  },{
    "hand": '63o',
    "value":12,
  },{
    "hand": '53o',
    "value":12,
  },{
    "hand": '43o',
    "value":12,
  },{
    "hand": '33',
    "value":6,
  },{
    "hand": '32s',
    "value":4,
  },{
    "hand": 'A2o',
    "value":12,
  },{
    "hand": 'K2o',
    "value":12,
  },{
    "hand": 'Q2o',
    "value":12,
  },{
    "hand": 'J2o',
    "value":12,
  },{
    "hand": 'T2o',
    "value":12,
  },{
    "hand": '92o',
    "value":12,
  },{
    "hand": '82o',
    "value":12,
  },{
    "hand": '72o',
    "value":12,
  },{
    "hand": '62o',
    "value":12,
  },{
    "hand": '52o',
    "value":12,
  },{
    "hand": '42o',
    "value":12,
  },{
    "hand": '32o',
    "value":12,
  },{
    "hand": '22',
    "value":6,
  },
];