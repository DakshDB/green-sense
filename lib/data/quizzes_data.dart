import '../models/quiz.dart';
import '../models/question.dart';
import '../models/category.dart';
import '../models/action_guide.dart';

final List<Quiz> allQuizzes = [
  Quiz(
    id: 'climate-change-basics',
    title: 'Climate Change Basics',
    description:
        'Test your understanding of climate science, impacts, and solutions. Perfect for beginners wanting to learn the fundamentals.',
    difficulty: Difficulty.easy,
    category: Category.climate,
    questions: [
      Question(
        text: 'What is the main greenhouse gas driving climate change?',
        options: ['Methane', 'Carbon Dioxide (CO2)', 'Nitrous Oxide', 'Water Vapor'],
        correctAnswerIndex: 1,
        explanation:
            'While all are greenhouse gases, CO2 accounts for about 76% of greenhouse gas emissions and persists in the atmosphere for centuries. It\'s primarily released from burning fossil fuels.',
      ),
      Question(
        text: 'How much has global temperature risen since pre-industrial times?',
        options: ['0.5°C (0.9°F)', '1.1°C (2.0°F)', '2.0°C (3.6°F)', '3.0°C (5.4°F)'],
        correctAnswerIndex: 1,
        explanation:
            'Global temperatures have increased approximately 1.1°C (2°F) since the late 1800s. The Paris Agreement aims to limit warming to 1.5°C to avoid the worst climate impacts.',
      ),
      Question(
        text: 'What percentage of climate scientists agree that humans cause climate change?',
        options: ['50%', '75%', '90%', '97%'],
        correctAnswerIndex: 3,
        explanation:
            'Multiple studies show that 97% of actively publishing climate scientists agree that climate-warming trends are extremely likely due to human activities. This represents overwhelming scientific consensus.',
      ),
      Question(
        text: 'Which sector produces the most greenhouse gas emissions globally?',
        options: ['Transportation', 'Energy (electricity & heat)', 'Agriculture', 'Industry'],
        correctAnswerIndex: 1,
        explanation:
            'Energy production (electricity and heat) accounts for about 42% of global emissions. This includes burning coal, oil, and gas for power. Transportation is second at about 24%.',
      ),
      Question(
        text: 'By how much have sea levels risen since 1880?',
        options: ['2-3 inches', '5-6 inches', '8-9 inches', '12-15 inches'],
        correctAnswerIndex: 2,
        explanation:
            'Sea levels have risen 8-9 inches (21-24 cm) since 1880, and the rate of rise has doubled since 2006. This threatens coastal communities worldwide and is accelerating as ice sheets melt.',
      ),
      Question(
        text: 'What is the current concentration of CO2 in the atmosphere?',
        options: ['280 ppm', '350 ppm', '400 ppm', '420 ppm'],
        correctAnswerIndex: 3,
        explanation:
            'CO2 levels are now over 420 parts per million, the highest in at least 800,000 years. Before the Industrial Revolution, they were around 280 ppm. This 50% increase drives global warming.',
      ),
      Question(
        text: 'Which country currently emits the most CO2 annually?',
        options: ['United States', 'China', 'India', 'Russia'],
        correctAnswerIndex: 1,
        explanation:
            'China emits the most CO2 annually (about 28% of global emissions), followed by the US (15%) and India (7%). However, per capita emissions tell a different story, with several smaller nations ranking higher.',
      ),
      Question(
        text: 'What is the primary cause of deforestation globally?',
        options: ['Logging', 'Agriculture', 'Urban expansion', 'Wildfires'],
        correctAnswerIndex: 1,
        explanation:
            'Agriculture accounts for about 80% of deforestation. This includes cattle ranching (especially in the Amazon), palm oil plantations, and soy production. Logging accounts for most of the remainder.',
      ),
      Question(
        text: 'How much of the world\'s electricity comes from renewable sources?',
        options: ['10%', '20%', '29%', '40%'],
        correctAnswerIndex: 2,
        explanation:
            'As of 2023, about 29% of global electricity comes from renewable sources (hydro, wind, solar, etc.). This percentage is growing rapidly as renewable costs fall and deployment accelerates.',
      ),
      Question(
        text: 'What year did the Paris Climate Agreement take effect?',
        options: ['2012', '2015', '2016', '2020'],
        correctAnswerIndex: 2,
        explanation:
            'The Paris Agreement was adopted in December 2015 and entered into force in November 2016. It aims to limit global warming to well below 2°C, preferably 1.5°C, compared to pre-industrial levels.',
      ),
    ],
  ),
  Quiz(
    id: 'sustainable-living-iq',
    title: 'Sustainable Living IQ',
    description:
        'How much do you know about living sustainably? Test your knowledge of eco-friendly practices, consumption, and daily choices.',
    difficulty: Difficulty.medium,
    category: Category.community,
    questions: [
      Question(
        text: 'How long do plastic bags take to decompose in a landfill?',
        options: ['50 years', '100 years', '500-1000 years', '10,000 years'],
        correctAnswerIndex: 2,
        explanation:
            'Plastic bags can take 500-1000 years to decompose in landfills, and even then, they break into microplastics rather than truly biodegrading. This is why reducing plastic bag use is so important.',
      ),
      Question(
        text: 'Which uses the most water to produce 1 kilogram?',
        options: ['Beef', 'Chicken', 'Vegetables', 'Grains'],
        correctAnswerIndex: 0,
        explanation:
            'Beef requires about 15,415 liters of water per kilogram, vastly more than chicken (4,325 liters), vegetables (322 liters), or grains (1,644 liters). This includes water for feed crops and drinking.',
      ),
      Question(
        text: 'What percentage of food produced globally is wasted?',
        options: ['10%', '20%', '33%', '50%'],
        correctAnswerIndex: 2,
        explanation:
            'Approximately one-third (33%) of all food produced for human consumption is wasted. This represents 1.3 billion tons annually and has massive environmental and social costs.',
      ),
      Question(
        text: 'How much can a household save annually by switching to LED bulbs?',
        options: ['$25', '$75', '$150', '$300+'],
        correctAnswerIndex: 2,
        explanation:
            'Switching all bulbs to LEDs can save a typical household $150+ per year on electricity. LEDs use 75% less energy than incandescent bulbs and last 25 times longer.',
      ),
      Question(
        text: 'What is the most effective way to reduce your carbon footprint?',
        options: ['Recycle more', 'Reduce meat consumption', 'Use less water', 'Drive an electric car'],
        correctAnswerIndex: 1,
        explanation:
            'While all help, reducing meat consumption (especially beef) has the biggest impact for individuals. Animal agriculture produces more greenhouse gases than all transportation combined.',
      ),
      Question(
        text: 'How much CO2 does one tree absorb annually on average?',
        options: ['10 lbs', '22 lbs', '48 lbs', '100 lbs'],
        correctAnswerIndex: 2,
        explanation:
            'A mature tree absorbs about 48 pounds (22 kg) of CO2 per year. However, this varies significantly by species, age, location, and conditions. Forests collectively absorb billions of tons annually.',
      ),
      Question(
        text: 'What percentage of ocean plastic pollution comes from fishing gear?',
        options: ['10%', '20%', '30%', '46%'],
        correctAnswerIndex: 3,
        explanation:
            'Fishing gear (especially nets) accounts for 46% of the Great Pacific Garbage Patch. These "ghost nets" continue catching and killing marine life for years after being abandoned.',
      ),
      Question(
        text: 'How many years does a reusable bag need to be used to offset its production emissions compared to single-use plastic?',
        options: ['5 uses', '50 uses', '131 uses', '500 uses'],
        correctAnswerIndex: 2,
        explanation:
            'A cotton tote bag needs about 131 uses to offset its production emissions compared to single-use plastic bags. However, it prevents hundreds of plastic bags from entering landfills and oceans.',
      ),
      Question(
        text: 'What is the most energy-efficient temperature to wash clothes?',
        options: ['Hot (140°F)', 'Warm (90°F)', 'Cool (70°F)', 'Cold (60°F)'],
        correctAnswerIndex: 3,
        explanation:
            'Cold water washing uses significantly less energy (90% less than hot) and is effective with modern detergents. Heating water accounts for about 90% of the energy used in washing clothes.',
      ),
      Question(
        text: 'How much energy does unplugging devices save on average per household annually?',
        options: ['$25', '$50', '$100', '$200'],
        correctAnswerIndex: 2,
        explanation:
            'Unplugging devices or using smart power strips can save about $100 per year. "Vampire energy" from devices on standby accounts for 5-10% of household electricity use.',
      ),
      Question(
        text: 'What is the carbon footprint of sending one email?',
        options: ['0.3 grams CO2', '4 grams CO2', '50 grams CO2', '100 grams CO2'],
        correctAnswerIndex: 1,
        explanation:
            'A typical email generates about 4 grams of CO2. Emails with attachments produce more (50g). While small individually, billions of emails daily add up. Deleting old emails reduces data center energy use.',
      ),
      Question(
        text: 'How long should you use a smartphone to minimize its environmental impact?',
        options: ['1 year', '2 years', '3+ years', 'Replace annually'],
        correctAnswerIndex: 2,
        explanation:
            'Using a smartphone for 3+ years significantly reduces its environmental impact. Manufacturing produces the most emissions (80% of total lifecycle). Extending device lifespan is one of the best eco-actions.',
      ),
    ],
  ),
  Quiz(
    id: 'pollution-detective',
    title: 'Pollution Detective',
    description:
        'Can you identify sources, impacts, and solutions to different types of pollution? Put your detective skills to the test!',
    difficulty: Difficulty.medium,
    category: Category.pollution,
    questions: [
      Question(
        text: 'What is the main source of microplastics in the ocean?',
        options: ['Cosmetic microbeads', 'Broken down plastic bottles', 'Synthetic clothing fibers', 'Fishing gear'],
        correctAnswerIndex: 2,
        explanation:
            'Synthetic clothing fibers released during washing are the largest source of microplastics in oceans. A single load of laundry can release 700,000 microfibers. Fishing gear is the main source of larger plastic pollution.',
      ),
      Question(
        text: 'How many people die prematurely from air pollution annually?',
        options: ['1 million', '3 million', '7 million', '10 million'],
        correctAnswerIndex: 2,
        explanation:
            'According to the WHO, approximately 7 million people die prematurely each year from air pollution. This makes it one of the greatest environmental health risks worldwide.',
      ),
      Question(
        text: 'Which industry is the second-largest polluter of water globally?',
        options: ['Agriculture', 'Fashion/Textiles', 'Mining', 'Food processing'],
        correctAnswerIndex: 1,
        explanation:
            'The fashion industry is the second-largest polluter of water globally. Textile dyeing and treatment contributes about 20% of industrial water pollution, releasing toxic chemicals into waterways.',
      ),
      Question(
        text: 'What percentage of the world\'s population lives in areas where air quality exceeds WHO guidelines?',
        options: ['50%', '75%', '90%', '99%'],
        correctAnswerIndex: 3,
        explanation:
            'An shocking 99% of the world\'s population lives in areas where air quality exceeds WHO guideline limits. Air pollution is a universal problem, though severity varies by location.',
      ),
      Question(
        text: 'What is the primary cause of ocean acidification?',
        options: ['Industrial waste', 'Agricultural runoff', 'CO2 absorption', 'Plastic pollution'],
        correctAnswerIndex: 2,
        explanation:
            'Oceans absorb about 30% of human-generated CO2, forming carbonic acid and lowering ocean pH. This ocean acidification threatens coral reefs, shellfish, and marine ecosystems.',
      ),
      Question(
        text: 'How many tons of plastic enter the ocean each year?',
        options: ['1 million', '5 million', '8 million', '12 million'],
        correctAnswerIndex: 2,
        explanation:
            'Approximately 8 million tons of plastic waste enter our oceans annually - equivalent to dumping one garbage truck of plastic into the ocean every minute.',
      ),
      Question(
        text: 'What is PM2.5 in air pollution?',
        options: ['A type of gas', 'Particles smaller than 2.5 micrometers', 'Pollution measurement scale', 'An air filter type'],
        correctAnswerIndex: 1,
        explanation:
            'PM2.5 refers to particulate matter with diameter less than 2.5 micrometers. These tiny particles can penetrate deep into lungs and even enter bloodstream, causing serious health issues.',
      ),
      Question(
        text: 'Which produces more greenhouse gas emissions per kilogram of protein?',
        options: ['Beef', 'Pork', 'Chicken', 'All are equal'],
        correctAnswerIndex: 0,
        explanation:
            'Beef produces about 27kg CO2 per kg of protein, vastly more than pork (12kg), chicken (7kg), or plant proteins (2kg). Cattle farming also requires more land and water.',
      ),
    ],
  ),
];
