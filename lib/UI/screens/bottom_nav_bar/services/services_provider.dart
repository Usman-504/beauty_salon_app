import 'package:flutter/material.dart';

import '../../../../generated/assets.dart';

class ServicesProvider with ChangeNotifier{

  List<Map<String, dynamic>> serviceCategories = [
    {
      'title': 'Nails',
      'image': Assets.nailsIcon,
      'services' : [
        {
          'title': 'Classic Manicure',
          'price': 'Rs. 1749/-',
          'image': Assets.classicManicureImage,
          'description' : 'Experience the ultimate classic manicure with precise nail shaping, meticulous cuticle care, and a stunning polish finish in your choice of color. Enjoy perfectly groomed nails that radiate elegance and sophistication. Treat yourself to a pampering session that enhances your natural beauty.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'French Manicure',
          'price': 'Rs. 1849/-',
          'image': Assets.frenchManicureImage,
          'description' : 'Elevate your style with a French manicure, featuring classic white tips that exude sophistication. Enjoy expert nail shaping and a glossy finish, providing a timeless, elegant look that complements any outfit. Perfect for any occasion, this manicure adds a touch of refined beauty to your nails.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Classic Pedicure',
          'price': 'Rs. 1999/-',
          'image': Assets.classicPedicureImage,
          'description' : 'Treat yourself to a classic pedicure that includes precise nail trimming, detailed cuticle care, and a relaxing foot soak. Complete your experience with a polish of your choice, leaving your feet perfectly pampered and beautifully polished. Enjoy the ultimate in comfort and elegance for your feet.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Acrylic Nails',
          'price': 'Rs. 3499/-',
          'image': Assets.acrylicNailsImage,
          'description' : 'Transform your look with acrylic nails, offering durable length and strength combined with a customizable shape and finish. Perfect for achieving a bold, glamorous style, these nails provide a versatile and eye-catching enhancement to your overall appearance. Enjoy a flawless and long-lasting manicure.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Nail Art/Designs',
          'price': 'Rs. 1599/-',
          'image': Assets.nailsArtImage,
          'description' : 'Express your creativity with custom nail art/design, showcasing intricate patterns, vibrant colors, and unique embellishments that reflect your personal style. From elegant and understated to bold and playful, these designs turn your nails into a canvas of artistic expression. Enjoy a standout look.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Nail Extensions',
          'price': 'Rs. 2849/-',
          'image': Assets.nailsExtensionsImage,
          'description' : 'Add length and sophistication with nail extensions, providing a durable and customizable solution for achieving stunning, long-lasting nails. Tailored to your preferences, these extensions enhance your look with elegance and style, ensuring your nails make a lasting impression. Enjoy extended nails.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
    {
      'title': 'Hairs',
      'image': Assets.hairsIcon,
      'services' : [
        {
          'title': 'Haircut & Styling',
          'price': 'Rs. 2249/-',
          'image': Assets.hairCutImage,
          'description' : 'Revitalize your look with a professional haircut and styling, expertly tailored to enhance your features and suit your preferences. Achieve a fresh, fashionable appearance that reflects your unique style and personality, leaving you with a polished and confident new look. Enjoy a transformation.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Hair Coloring',
          'price': 'Rs. 3849/-',
          'image': Assets.hairColorImage,
          'description' : 'Transform your hair with expert coloring, offering vibrant, custom hues that perfectly complement your natural beauty. Enjoy a glossy finish that adds depth and shine, creating a stunning, head-turning look tailored just for you. Elevate your style with a color treatment that enhances your overall appearance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Hair Extensions',
          'price': 'Rs. 1199/-',
          'image': Assets.hairExtensionsImage,
          'description' : 'Add volume and length with luxurious hair extensions, designed to seamlessly blend with your natural hair for a stunning, effortless look. Enjoy enhanced fullness and flowing length, creating a glamorous, natural-looking transformation that elevates your style with ease and sophistication.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Hair Straightening',
          'price': 'Rs. 4879/-',
          'image': Assets.hairStraightningImage,
          'description' : 'Achieve sleek, smooth hair with professional straightening, expertly reducing frizz and delivering a flawless, polished finish. Enjoy a sophisticated, long-lasting look that enhances your hair’s natural shine and manageability, providing a refined style that remains effortlessly elegant and stunning.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Hair Treatment',
          'price': 'Rs. 2999/-',
          'image': Assets.hairTreatmentImage,
          'description' : 'Revitalize your hair with a nourishing treatment that repairs damage, restores moisture, and enhances overall health. Enjoy locks that are not only healthy and shiny but also vibrant and incredibly full of life, leaving your hair looking and feeling its absolute best and most radiant and glamorous.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
    {
      'title': 'Facial',
      'image': Assets.facialIcon,
      'services' : [
        {
          'title': 'Classic Facial',
          'price': 'Rs. 1499/-',
          'image': Assets.classicFacialImage,
          'description' : 'Pamper yourself with a classic facial that includes deep cleansing, gentle exfoliation, and a soothing mask. Enjoy a refreshing transformation as impurities are removed and your complexion is revitalized, leaving you with healthy, radiant skin that maintains its vibrant glow and lasting brilliance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Cleansing Facial',
          'price': 'Rs. 4999/-',
          'image': Assets.cleansingFacialImage,
          'description' : 'Refresh your complexion with a cleansing facial that focuses on deep pore cleansing, exfoliation, and a purifying mask. Enjoy clear, glowing skin as impurities are thoroughly removed, revitalizing your complexion and leaving you with a fresh, radiant appearance that shines with health and vitality.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Anti-Aging Facial',
          'price': 'Rs. 3449/-',
          'image': Assets.antiAgingFacialImage,
          'description' : 'Rejuvenate your skin with an anti-aging facial that includes targeted treatments designed to reduce fine lines, enhance elasticity, and promote a youthful, radiant glow. Experience a revitalized complexion as these treatments work to restore your skin’s natural vibrancy and firmness, leaving you with a youthful appearance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Hydrating Facial',
          'price': 'Rs. 2949/-',
          'image': Assets.hydratingFacialImage,
          'description' : 'Quench your skin’s thirst with a deeply hydrating facial, expertly designed to replenish moisture, soothe dryness, and leave your complexion plump and glowing. Revel in a revitalized, well-hydrated look as your skin feels refreshed, radiant, and luxuriously supple and beautifully rejuvenated.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Brightening Facial',
          'price': 'Rs. 2279/-',
          'image': Assets.brighteningFacialImage,
          'description' : 'Illuminate your skin with a brightening facial that blends gentle exfoliation with advanced treatments to reduce dullness and enhance your natural radiance. Revel in a refreshed, luminous complexion as your skin is revitalized, revealing a vibrant, healthy glow that radiates youthful vitality and brilliance.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
    {
      'title': 'Waxing',
      'image': Assets.waxingIcon,
      'services' : [
        {
          'title': 'Leg Waxing',
          'price': 'Rs. 2499/-',
          'image': Assets.legWaxingImage,
          'description' : 'Experience smooth, hair-free legs with our expert leg waxing service, delivering thorough and comfortable hair removal for long-lasting, silky-smooth results. Enjoy extended smoothness and the confidence of impeccably polished legs, beautifully and effortlessly prepared for any special occasion.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Arm Waxing',
          'price': 'Rs. 1999/-',
          'image': Assets.armWaxingImage,
          'description' : 'Achieve silky-smooth arms with our professional arm waxing service, providing effective hair removal and a flawless finish for a clean, sleek look. Enjoy long-lasting smoothness and the confidence of beautifully polished arms, impeccably and effortlessly ready for every special occasion or important event.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Face Waxing',
          'price': 'Rs. 2749/-',
          'image': Assets.faceWaxingImage,
          'description' : 'Enjoy a smooth, hair-free complexion with our face waxing service, which gently and effectively removes unwanted facial hair for a flawlessly polished appearance. Revel in the confidence of a clean, radiant face that beautifully highlights your natural beauty and youthful, glowing radiance and vibrant allure.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
    {
      'title': 'Threading',
      'image': Assets.threadingIcon,
      'services' : [
        {
          'title': 'Eyebrow Threading',
          'price': 'Rs. 199/-',
          'image': Assets.eyebrowThreadingImage,
          'description' : 'Define your brows with precise eyebrow threading, delivering a clean, sculpted shape that enhances your natural features with minimal discomfort. Enjoy perfectly shaped brows that frame your face beautifully, accentuating and highlighting your best features with effortless elegance and timeless sophistication.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Forehead Threading',
          'price': 'Rs. 149/-',
          'image': Assets.foreheadThreadingImage,
          'description' : 'Achieve a smooth, hair-free forehead with our threading service, providing precise removal of unwanted hair for a clean, polished look. Enjoy a flawless, refined appearance that effortlessly highlights your natural beauty and enhances your overall radiance, self-confidence, and elegance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Lip Threading',
          'price': 'Rs. 159/-',
          'image': Assets.lipThreadingImage,
          'description' : 'Achieve flawlessly smooth and radiant lips with our expert threading service. Our precise technique ensures the gentle and accurate removal of unwanted hair, leaving your skin feeling clean, refreshed, and beautifully polished. Perfect for enhancing your natural beauty with a smooth, seamless finish.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Full Face Threading',
          'price': 'Rs. 449/-',
          'image': Assets.fullFaceThreadingImage,
          'description' : 'Experience a perfectly smooth and flawless complexion with our full face threading service. Our gentle technique effectively removes unwanted hair, ensuring a clean, even, and refreshed appearance. Ideal for achieving a polished, radiant look that beautifully enhances your natural beauty.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
    {
      'title': 'Skincare',
      'image': Assets.skinCareIcon,
      'services' : [
        {
          'title': 'Skin Consultation',
          'price': 'Rs. 1149/-',
          'image': Assets.skinConsultationImage,
          'description' : 'Receive expert guidance with our skincare consultation, tailored to address your specific skin concerns. We offer personalized product recommendations and treatments designed to enhance your skin\'s health and achieve a radiant, glowing complexion. Ideal for those seeking a customized approach to skincare.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Hydration Therapy',
          'price': 'Rs. 7999/-',
          'image': Assets.hydrationTheraphyImage,
          'description' : 'Revitalize your skin with our advanced hydration therapy, which delivers deep moisture and essential nutrients to restore optimal balance. This luxurious treatment leaves your complexion feeling refreshed, glowing, and beautifully luminous, perfect for achieving a revitalized, radiant, and exceptionally healthy appearance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'LED Light Therapy',
          'price': 'Rs. 8399/-',
          'image': Assets.ledLightTheraphyImage,
          'description' : 'Enhance your skin’s health with our cutting-edge LED light therapy, which uses targeted light wavelengths to improve texture, diminish signs of aging, and significantly boost overall radiance. This advanced treatment rejuvenates your complexion, promoting a youthful, glowing, and visibly revitalized appearance.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
    {
      'title': 'Eyebrow',
      'image': Assets.eyeBrowIcon,
      'services' : [
        {
          'title': 'Eyebrow Shaping',
          'price': 'Rs. 3799/-',
          'image': Assets.eyebrowShapingImage,
          'description' : 'Achieve perfectly shaped brows with our professional eyebrow shaping service, meticulously designed to complement your unique natural features. Our precise technique frames your face beautifully, enhancing your overall look with a polished, balanced, and effortlessly harmonious appearance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Eyebrow Tinting',
          'price': 'Rs. 4999/-',
          'image': Assets.eyebrowTintingImage,
          'description' : 'Enhance your brows with our expert eyebrow tinting service, which adds rich color and definition for a fuller, well-groomed appearance. This luxurious treatment provides a stylish complement to your look, ensuring your brows are both striking and effortlessly polished, with a beautifully refined and defined finish.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Eyelash Extensions',
          'price': 'Rs. 1399/-',
          'image': Assets.eyelashExtensionsImage,
          'description' : 'Elevate your look with our premium eyelash extensions, offering voluminous and long-lasting lashes that enhance length and add dramatic flair. Enjoy captivating, effortless beauty with lashes that make a stunning impact and require minimal maintenance, ensuring a truly striking and glamorous appearance.',
          'staticIcon': Icons.arrow_forward,
        },
        {
          'title': 'Eyelash Perming',
          'price': 'Rs. 3899/-',
          'image': Assets.eyelashPermingImage,
          'description' : 'Transform your lashes with our expert eyelash perming service, which creates beautifully curled lashes that add impressive lift and volume. This innovative treatment enhances your natural beauty, providing a glamorous, effortlessly chic look that lasts, making your eyes truly captivating and standout.',
          'staticIcon': Icons.arrow_forward,
        },
      ],
    },
  ];

}