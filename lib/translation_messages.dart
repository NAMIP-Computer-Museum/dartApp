// ignore_for_file: prefer_adjacent_string_concatenation

import 'package:get/get.dart';

class TranslationMessages extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'fr_FR': {
      'introduction': 'Introduction',
      'rechercher': 'Rechercher',
      'ligne_du_temps': 'Ligne du temps',
      'videos': 'Videos',
      'quiz': 'Quiz',
      'a_propos': 'A propos',
      'titreIntroduction' : "Introduction",
      'descriptionIntroduction' : "Cette application a été conçue pour vous guider dans l'exposition temporaire 'micro-ordinateur, még@ révolution'. Elle s'inscrit dans le cycle 'De l’informatique antique à l’informatique quantique'.\n\nL'exposition retrace l’histoire, depuis les années 1970 jusqu'au milieu des années 1990, de l’émergence d’une informatique interactive, personnelle, conviviale et centrée sur l’utilisateur final. Tout citoyen peut pour la première acquérir son ordinateur individuel, par contraste avec l'exposition précédente consacrée aux ordinateurs des années 1960 très onéreux et réservés aux organisations qui en avaient les moyens.\n\nL'exposition ne se concentre pas uniquement sur l'évolution technique des micro-ordinateurs mais illustre aussi en parallèle, l'émergence des interfaces graphiques utilisateurs et leur intégration dans ces machines grand public.",
      'modeEmploi' : "Mode d'emploi",
      'titreModeEmploi' : "Mode Emploi",
      'descriptionModeEmploi' : "L'application est structurée selon une ligne du temps qui suit le cheminement de l'exposition.\n\nL'application propose des filtres permettant de sélectionner une ou plusieurs phases ou thématiques telles que :\n\n- les micro-ordinateurs présentés dans l'exposition\n- les micros-processeurs mis en oeuvre\n- les développements des interfaces graphiques\n- les systèmes d'exploitation\n- les applications majeures\n\nChaque thème est expliqué via une fiche spécifique illustrée par une photo zoomable et parfois une petite vidéo.\n\nA terme, l'application sera complètement disponible en trois langues avec un sous-titrage correspondants des vidéos diffusées.\n\nUn petit quiz ludique vous est aussi proposé pour tester vos connaissances.",
      'titreApropos' : "A Propos",
      'descriptionApropos' : "\nCette application a été développée par les bénévoles du musée NAM-IP à des fins de support pour la visite. Un guide papier plus complet est en vente à la boutique du musée.\n\nVos commentaires d'amélioration sont les bienvenus en donnant un retour à la réception.\n\n(C) 2021 NAM-IP",
      'friseEntiere' : "Frise Entière",
      'debut': "Début",
      'phase1': "Phase 1",
      'phase2': "Phase 2",
      'phase3': "Phase 3",
      'vueCompacte': "Vue Compacte",
      'voirPlus': "Voir plus",
      'video': "Video",
      'choixDuNiveau': "Choix du niveau",
      'facile': "Facile",
      'difficile': "Difficile",
      'suite': "Suite",
      'scoreQuiz': "Score Quiz",
      'felicitations' : "Félicitations !",
      'reessaye' : "Réessaye !",
      'reessayer' : "Réessayer",
      'accueil' : "Accueil",

      //questions quiz
      'question1' : "Quand est né {person} ?",
      'question2' : "Quand est décédé {person} ?",
      'question3' : "Quelle est le prénom de {lastname} ?",
      'question4' : "D'où vient {person} ?",

      //TODO à completer pour les autres langues
      'favoris': "Favoris",
      'jeux': "Jeux",
    },
    'nl_NL': {
      'introduction': 'Inleiding',
      'rechercher': 'Zoeken',
      'ligne_du_temps': 'Tijdlijn',
      'videos': 'Videos',
      'quiz': 'Quiz',
      'a_propos': 'Meer uitleg',
      'titreIntroduction' : "Inleiding",
      'descriptionIntroduction' : "Deze applicatie is ontworpen om u door de tijdelijke tentoonstelling 'microcomputer, meg@revolutie' te leiden.Ze maakt deel uit van de cyclus 'Van oude computers naar kwantumcomputers'.\n\nDe tentoonstelling schetst de geschiedenis van de opkomst van interactief persoonlijk, gebruiksvriendelijk en op de eindgebruiker gericht computergebruik, vanaf de jaren '70 tot het midden van de jaren '90.Idereen kan voor het eerst zijn PC aanschaffen, in tegenstelling tot de vorige tentoonstellingtoegewijd aan zeer dure computers uit de jaren zestig en voorbehouden aan organisaties die die kunnen betalen.\n\nDe tentoonstelling richt zich niet alleen op de technische ontwikkeling van microcomputers, maar illustreert tegelijkertijd de opkomst van grafische gebruikersinterfaces en hun integratie in deze algemene openbare machines.",
      'modeEmploi' : "Gebruiksaanwijzing",
      'titreModeEmploi' : "Gebruiksaanwijzing",
      'descriptionModeEmploi' : "De applicatie is gestructureerd volgens een tijdlijn die het parcours van de tentoonstelling volgt.\nOm je gemakkelijk in een bepaalde fase of thema te kunnen situeren, maakt de tentoonstelling het mogelijk om eenvoudig te filterenvolgens een van de temporele fasen of het geheel. Voor de betreffende periode kunnen we ook filteren op:\n\n- de microcomputers gepresenteerd in de tentoonstelling\n- de microprocessors geïmplementeerd\n- de ontwikkeling van grafische interfaces\n- besturingssystemen\n- belangrijke toepassingen\n\nElk thema wordt uitgelegd via een specifiek fiche geïllustreerd door een zoombare foto en soms een kleine video.\nUiteindelijk zal de applicatie beschikbaar zijn in drie talen met bijbehorende ondertitels van de uitgezonden video's.\n\nEr is ook een kleine quiz beschikbaar om je kennis te testen.",
      'titreApropos' : "Meer uitleg",
      'descriptionApropos' : "Deze applicatie is ontwikkeld door de vrijwilligers van het NAM-IP museum ter ondersteuning van het bezoek.Een uitgebreide papieren gids is te koop in de museumwinkel.\n\nUw opmerkingen voor verbetering zijn welkom door feedback te geven aan de receptie.\n\n(C) 2021 NAM-IP",
      'friseEntiere' : "Alle tijdlijnen",
      'debut': "Begin",
      'phase1': "Periode 1",
      'phase2': "Periode 2",
      'phase3': "Periode 3",
      'vueCompacte': "Compacte weergave",
      'voirPlus': "Bekijk Meer",
      'video': "Video",
      //TODO à verifier
      'choixDuNiveau': "Kies niveau",
      'facile': "Makkelijk",
      'difficile': "Moeilijk",
      //Fin_TODO
      'suite': "Volgende vraag",
      'scoreQuiz': "Score Quiz",
      'felicitations' : "Gefeliciteerd !", //TODO à verifier
      'reessaye' : "Probeer opnieuw !", //TODO à verifier
      'reessayer' : "Resetten",
      'accueil' : "Onthaal",

      //questions quiz
      'question1' : "Quand est né {person} ?",
      'question2' : "Quand est décédé {person} ?",
      'question3' : "Quelle est le prénom de {lastname} ?",
      'question4' : "D'où vient {person} ?", //TODO à verifier
    },
    'en_US': {
      'introduction': 'Introduction',
      'rechercher': 'Search',
      'ligne_du_temps': 'Timeline',
      'videos': 'Videos',
      'quiz': 'Quiz',
      'a_propos': 'About us',
      'titreIntroduction' : "Introduction",
      'descriptionIntroduction' : "This application has been designed to guide you through the temporary exhibition 'microcomputer, meg @ revolution'. It is part of the cycle 'From ancient computing to quantum computing'.\n\nThe exhibition traces history, from the 1970s to the mid-1990s, the emergence of interactive, personal, user-friendly and end-user-centric computing. He can for the first time acquire his personal computer, in contrast to the previous exhibition dedicated to very expensive computers from the 1960s and reserved for organizations that can afford them.\n\nThe exhibition does not only focus on the technical development of microcomputers but also illustrates at the same time, the emergence of graphical user interfaces and their integration into these general public machines.",
      'modeEmploi' : "Manual",
      'titreModeEmploi' : "Manual",
      'descriptionModeEmploi' : "The application is structured according to a timeline that follows the course of the exhibition.\nIn order to easily situate yourself in a specific phase or theme, the exhibition makes it possible to easily filteraccording to one of the temporal phases or the whole. For the period concerned, we can also filter on:\n\n- the microcomputers presented in the exhibition\n- the microprocessors implemented\n- the development of graphical interfaces\n- operating systems\n- major applications\n\nEach dimension is explained via a specific sheet illustrated by a zoomable photo and sometimes a small video.\nEventually the application will be available in three languages ​​with corresponding subtitles of the videos broadcast.\n\nA small quiz is also available to test your knowledge.",
      'titreApropos' : "About us",
      'descriptionApropos' : "This application was developed by the volunteers of the NAM-IP museum for the purpose of support for the visit.A more complete paper guide is on sale at the museum shop.\n\nYour comments for improvement are welcome by giving feedback to the front desk.\n\n(C) 2021 NAM-IP",
      'friseEntiere' : "All Timeline",
      'debut': "Beginning",
      'phase1': "Phase 1",
      'phase2': "Phase 2",
      'phase3': "Phase 3",
      'vueCompacte': "Compact View",
      'voirPlus': "See More",
      'video': "Video",
      'choixDuNiveau': "Choose level",
      'facile': "Easy",
      'difficile': "Difficult",
      'suite': "Continue",
      'scoreQuiz': "Quiz Score",
      'felicitations' : "Congratulations !",
      'reessaye' : "Try again !",
      'reessayer' : "Reset",
      'accueil' : "Home",

      //questions quiz
      'question1' : "When est né {person} ?",
      'question2' : "When est décédé {person} ?",
      'question3' : "What est le prénom de {lastname} ?",
      'question4' : "Where vient {person} ?", //TODO à verifier
    },
  };
}