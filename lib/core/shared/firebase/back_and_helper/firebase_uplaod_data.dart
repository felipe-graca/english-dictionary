import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

const String keywords =
    """Car/nHouse/nDog/nCat/nChair/nTable/nBook/nPen/nComputer/nPhone/nWindow/nDoor/nLamp/nBed/nPillow/nBlanket/nClock/nMirror/nPicture/nGuitar/nPiano/nMusic/nSong/nDance/nParty/nMovie/nTheater/nTicket/nCoffee/nTea/nJuice/nWater/nMilk/nBread/nButter/nCheese/nSalad/nPizza/nPasta/nRice/nChicken/nFish/nSteak/nFruit/nVegetable/nCarrot/nTomato/nPotato/nOnion/nGarlic/nSalt/nPepper/nSugar/nFlour/nOil/nVinegar/nHoney/nMustard/nKetchup/nMayonnaise/nShirt/nPants/nDress/nShoes/nSocks/nHat/nGloves/nJacket/nCoat/nScarf/nBag/nWallet/nKey/nWatch/nRing/nBracelet/nNecklace/nEarrings/nGlasses/nHat/nSun/nMoon/nStar/nSky/nCloud/nRain/nSnow/nWind/nStorm/nThunder/nLightning/nBeach/nOcean/nSand/nWave/nShell/nSun/nIsland/nMountain/nForest/nTree/nFlower/nGrass/nRiver/nLake/nBridge/nRoad/nCar/nBus/nTrain/nBike/nPlane/nShip/nTravel/nAdventure/nExplore/nMap/nCompass/nBackpack/nCamera/nPassport/nTicket/nHotel/nRoom/nBed/nBath/nShower/nTowel/nSoap/nShampoo/nConditioner/nToothbrush/nToothpaste/nMirror/nSink/nToilet/nWindow/nDoor/nLight/nSwitch/nPlug/nWire/nBattery/nSocket/nOutlet/nLamp/nTable/nChair/nDesk/nComputer/nKeyboard/nMouse/nMonitor/nLaptop/nPrinter/nScanner/nInternet/nWebsite/nEmail/nMessage/nChat/nCall/nVideo/nPhoto/nMusic/nMovie/nGame/nPlay/nToy/nPuzzle/nBall/nBike/nSkate/nSwim/nRun/nJump/nDance/nSing/nPaint/nDraw/nWrite/nRead/nLearn/nStudy/nTeach/nWork/nJob/nOffice/nBoss/nColleague/nCustomer/nMoney/nBank/nCash/nCard/nPay/nBuy/nSell/nMarket/nShop/nStore/nMall/nFashion/nStyle/nBeauty/nHealth/nFitness/nExercise/nYoga/nMeditation/nRelax/nSleep/nWake/nDream/nGoal/nPlan/nSuccess/nFailure/nChallenge/nChange/nHope/nLove/nFriend/nFamily/nHome/nLife/nTime/nMoment/nMemory/nExperience/nEmotion/nHappiness/nSadness/nAnger/nFear/nSurprise/nLaughter/nSmile/nTears/nSong/nDance/nArt/nPoetry/nTheater/nFilm/nStory/nNovel/nPoetry/nHistory/nScience/nNature/nSpace/nUniverse/nPlanet/nEarth/nSun/nMoon/nStar/nGalaxy/nSolar/nEnergy/nLight/nGravity/nMatter/nAtom/nMolecule/nCell/nBody/nHealth/nDisease/nMedicine/nDoctor/nPatient/nHospital/nNurse/nBlood/nHeart/nBrain/nMind/nThought/nIdea/nKnowledge/nWisdom/nLearning/nSchool/nTeacher/nStudent/nExam/nGrade/nHomework/nProject/nTest/nStudy/nUniversity/nCollege/nDegree/nCareer/nGoal/nAchievement/nSuccess/n""";

class FirebaseDataManagement {
  FirebaseDataManagement._();
  static var uuid = const Uuid();
  static final ref = FirebaseFirestore.instance;
  static List<String> _stringToList(String str) => str.split("/n");

  static Future<void> createDataStructureAndSetData() async => _stringToList(keywords).map((e) async {
        var id = uuid.v4();

        await ref.collection('words').doc(id).set({
          "id": id,
          "word": e,
        });
      }).toList();
}
