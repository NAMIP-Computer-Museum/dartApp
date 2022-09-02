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
      'descriptionIntroduction' : "Cette application présente l'évolution des micro-ordinateurs entre les  années 1970 et 1990. Cette période se caractérise par l'émergence d’une informatique interactive, personnelle, conviviale et centrée sur l’utilisateur final. L'application permet une navigation au moyen d'une ligne de temps configurable par période et thèmes tels que machines, processeurs, interfaces graphiques, systèmes d'exploitation et applications. Un quiz permet aussi de tester ses connaissances.\n\nL'application multilingue était initialement le guide de l'exposition temporaire 'micro-ordinateur, még@ révolution' conçue par le musée de l'informatique NAM-IP de Namur (Belgique) entre juin 2021 et juin 2022. Sans être exhaustive, elle se veut représentative de cette thématique et sera progressivement enrichie lors de mises-à-jour. Cette application embarque tous le contenu y compris des vidéos et est donc assez conséquente en taille.",
      'modeEmploi' : "Mode d'emploi",
      'titreModeEmploi' : "Mode Emploi",
      'descriptionModeEmploi' : "L'application est structurée selon une ligne du temps qui suit le cheminement de l'exposition.\n\n"+
          "L'application propose des filtres permettant de sélectionner une ou plusieurs phases ou thématiques telles que :\n\n"+
          "- les micro-ordinateurs présentés dans l'exposition\n"+
          "- les micros-processeurs mis en oeuvre\n"+
          "- les développements des interfaces graphiques\n"+
          "- les systèmes d'exploitation\n"+
          "- les applications majeures\n\n"+
          "Chaque thème est expliqué via une fiche spécifique illustrée par une photo zoomable et parfois une petite vidéo.\n\n"+
          "A terme, l'application sera complètement disponible en trois langues avec un sous-titrage correspondants des vidéos diffusées.\n\n"+
          "Un petit quiz ludique vous est aussi proposé pour tester vos connaissances.",
      'titreApropos' : "A Propos",
      'descriptionApropos' : "\nCette application a été développée par les bénévoles du musée NAM-IP à des fins de support pour la visite. "+
          "Un guide papier plus complet est en vente à la boutique du musée.\n\n"+
          "Vos commentaires d'amélioration sont les bienvenus en donnant un retour à la réception.\n\n"+
          "(C) 2021 NAM-IP",
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
      'accueil' : "Accueil"
    },
    'nl_NL': {
      'introduction': 'Inleiding',
      'rechercher': 'Zoeken',
      'ligne_du_temps': 'Tijdlijn',
      'videos': 'Videos',
      'quiz': 'Quiz',
      'a_propos': 'Meer uitleg',
      'titreIntroduction' : "Inleiding",
      'descriptionIntroduction' : "Deze toepassing toont de evolutie van microcomputers tussen de jaren 1970 en 1990. Deze periode wordt gekenmerkt door de opkomst van interactieve, persoonlijke, gebruikersvriendelijke en op de eindgebruiker gerichte informatica. De toepassing maakt navigatie mogelijk door een configureerbare tijdlijn per periode en thema's zoals machines, processoren, grafische interfaces, besturingssystemen en toepassingen. Een quiz is ook beschikbaar om zijn kennis te testen.\n\nDeze meertalige applicatie was aanvankelijk de gids bij de tijdelijke tentoonstelling 'microcomputer, meg@revolutie' van het NAM-IP computermuseum in Namen (België) tussen juni 2021 en juni 2022. Hoewel niet uitputtend, is het wel representatief voor dit thema. Het zal geleidelijk worden verrijkt met updates. Deze applicatie bevat alle inhoud, inclusief video's, en is daarom vrij groot.",
      'modeEmploi' : "Gebruiksaanwijzing",
      'titreModeEmploi' : "Gebruiksaanwijzing",
      'descriptionModeEmploi' : "De applicatie is gestructureerd volgens een tijdlijn die het parcours van de tentoonstelling volgt.\n"+
          "Om je gemakkelijk in een bepaalde fase of thema te kunnen situeren, maakt de tentoonstelling het mogelijk om eenvoudig te filteren"+
          "volgens een van de temporele fasen of het geheel. Voor de betreffende periode kunnen we ook filteren op:\n\n"+
          "- de microcomputers gepresenteerd in de tentoonstelling\n"+
          "- de microprocessors geïmplementeerd\n"+
          "- de ontwikkeling van grafische interfaces\n" +
          "- besturingssystemen\n" +
          "- belangrijke toepassingen\n\n"+
          "Elk thema wordt uitgelegd via een specifiek fiche geïllustreerd door een zoombare foto en soms een kleine video.\n" +
          "Uiteindelijk zal de applicatie beschikbaar zijn in drie talen met bijbehorende ondertitels van de uitgezonden video's.\n\n" +
          "Er is ook een kleine quiz beschikbaar om je kennis te testen.",
      'titreApropos' : "Meer uitleg",
      'descriptionApropos' : "Deze applicatie is ontwikkeld door de vrijwilligers van het NAM-IP museum ter ondersteuning van het bezoek." +
          "Een uitgebreide papieren gids is te koop in de museumwinkel.\n\n" +
          "Uw opmerkingen voor verbetering zijn welkom door feedback te geven aan de receptie.\n\n" +
          "(C) 2021 NAM-IP",
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
      'accueil' : "Onthaal"
    },
    'en_US': {
      'introduction': 'Introduction',
      'rechercher': 'Search',
      'ligne_du_temps': 'Timeline',
      'videos': 'Videos',
      'quiz': 'Quiz',
      'a_propos': 'About us',
      'titreIntroduction' : "Introduction",
      'descriptionIntroduction' : "This application presents the evolution of microcomputers between the 1970s and 1990s. This period is characterised by the emergence of interactive, personal, user-friendly and user-centred computing. The application navigation relies on a timeline which can be configured by period and themes such as machines, processors, graphical interfaces, operating systems and applications. A quiz is also available.\n\nThis multilingual application served initially as guide for the temporary exhibition 'microcomputer, meg@revolution' designed by the NAM-IP computer museum in Namur (Belgium) between June 2021 and June 2022. Without being exhaustive, it is intended to be representative of this theme and will be enriched through updates. It embeds all the content including videos and is therefore quite large in size.",
      'modeEmploi' : "Manual",
      'titreModeEmploi' : "Manual",
      'descriptionModeEmploi' : "The application is structured according to a timeline that follows the course of the exhibition.\n"+
          "In order to easily situate yourself in a specific phase or theme, the exhibition makes it possible to easily filter"+
          "according to one of the temporal phases or the whole. For the period concerned, we can also filter on:\n\n"+
          "- the microcomputers presented in the exhibition\n"+
          "- the microprocessors implemented\n"+
          "- the development of graphical interfaces\n"+
          "- operating systems\n" +
          "- major applications\n\n" +
          "Each dimension is explained via a specific sheet illustrated by a zoomable photo and sometimes a small video.\n" +
          "Eventually the application will be available in three languages ​​with corresponding subtitles of the videos broadcast.\n\n" +
          "A small quiz is also available to test your knowledge.",
      'titreApropos' : "About us",
      'descriptionApropos' : "This application was developed by the volunteers of the NAM-IP museum for the purpose of support for the visit." +
          "A more complete paper guide is on sale at the museum shop.\n\n" +
          "Your comments for improvement are welcome by giving feedback to the front desk.\n\n" +
          "(C) 2021 NAM-IP",
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
      'accueil' : "Home"
    },
  };
}