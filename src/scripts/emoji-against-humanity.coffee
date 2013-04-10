# Description:
#   Cards Against Humanity + Emoji
#
# Commands:
module.exports = (robot) ->

  robot.respond /pick a card/i, (msg) ->
    emoji_list = [
      ':bowtie:',
      ':smile:',
      ':laughing:',
      ':blush:',
      ':smiley:',
      ':relaxed:',
      ':smirk:',
      ':heart_eyes:',
      ':kissing_heart:',
      ':kissing_closed_eyes:',
      ':flushed:',
      ':relieved:',
      ':satisfied:',
      ':grin:',
      ':wink:',
      ':stuck_out_tongue_winking_eye:',
      ':stuck_out_tongue_closed_eyes:',
      ':grinning:',
      ':kissing:',
      ':kissing_smiling_eyes:',
      ':stuck_out_tongue:',
      ':sleeping:',
      ':worried:',
      ':frowning:',
      ':anguished:',
      ':open_mouth:',
      ':grimacing:',
      ':confused:',
      ':hushed:',
      ':expressionless:',
      ':unamused:',
      ':sweat_smile:',
      ':sweat:',
      ':disappointed_relieved:',
      ':weary:',
      ':pensive:',
      ':disappointed:',
      ':confounded:',
      ':fearful:',
      ':cold_sweat:',
      ':persevere:',
      ':cry:',
      ':sob:',
      ':joy:',
      ':astonished:',
      ':scream:',
      ':neckbeard:',
      ':tired_face:',
      ':angry:',
      ':rage:',
      ':triumph:',
      ':sleepy:',
      ':yum:',
      ':mask:',
      ':sunglasses:',
      ':dizzy_face:',
      ':imp:',
      ':smiling_imp:',
      ':neutral_face:',
      ':no_mouth:',
      ':innocent:',
      ':alien:',
      ':yellow_heart:',
      ':blue_heart:',
      ':purple_heart:',
      ':heart:',
      ':green_heart:',
      ':broken_heart:',
      ':heartbeat:',
      ':heartpulse:',
      ':two_hearts:',
      ':revolving_hearts:',
      ':cupid:',
      ':sparkling_heart:',
      ':sparkles:',
      ':star:',
      ':star2:',
      ':dizzy:',
      ':boom:',
      ':collision:',
      ':anger:',
      ':exclamation:',
      ':question:',
      ':grey_exclamation:',
      ':grey_question:',
      ':zzz:',
      ':dash:',
      ':sweat_drops:',
      ':notes:',
      ':musical_note:',
      ':fire:',
      ':hankey:',
      ':poop:',
      ':shit:',
      ':+1:',
      ':thumbsup:',
      ':-1:',
      ':thumbsdown:',
      ':ok_hand:',
      ':punch:',
      ':facepunch:',
      ':fist:',
      ':v:',
      ':wave:',
      ':hand:',
      ':raised_hand:',
      ':open_hands:',
      ':point_up:',
      ':point_down:',
      ':point_left:',
      ':point_right:',
      ':raised_hands:',
      ':pray:',
      ':point_up_2:',
      ':clap:',
      ':muscle:',
      ':metal:',
      ':fu:',
      ':walking:',
      ':runner:',
      ':running:',
      ':couple:',
      ':family:',
      ':two_men_holding_hands:',
      ':two_women_holding_hands:',
      ':dancer:',
      ':dancers:',
      ':ok_woman:',
      ':no_good:',
      ':information_desk_person:',
      ':raising_hand:',
      ':bride_with_veil:',
      ':person_with_pouting_face:',
      ':person_frowning:',
      ':bow:',
      ':couplekiss:',
      ':couple_with_heart:',
      ':massage:',
      ':haircut:',
      ':nail_care:',
      ':boy:',
      ':girl:',
      ':woman:',
      ':man:',
      ':baby:',
      ':older_woman:',
      ':older_man:',
      ':person_with_blond_hair:',
      ':man_with_gua_pi_mao:',
      ':man_with_turban:',
      ':construction_worker:',
      ':cop:',
      ':angel:',
      ':princess:',
      ':smiley_cat:',
      ':smile_cat:',
      ':heart_eyes_cat:',
      ':kissing_cat:',
      ':smirk_cat:',
      ':scream_cat:',
      ':crying_cat_face:',
      ':joy_cat:',
      ':pouting_cat:',
      ':japanese_ogre:',
      ':japanese_goblin:',
      ':see_no_evil:',
      ':hear_no_evil:',
      ':speak_no_evil:',
      ':guardsman:',
      ':skull:',
      ':feet:',
      ':lips:',
      ':kiss:',
      ':droplet:',
      ':ear:',
      ':eyes:',
      ':nose:',
      ':tongue:',
      ':love_letter:',
      ':bust_in_silhouette:',
      ':busts_in_silhouette:',
      ':speech_balloon:',
      ':thought_balloon:',
      ':feelsgood:',
      ':finnadie:',
      ':goberserk:',
      ':godmode:',
      ':hurtrealbad:',
      ':rage1:',
      ':rage2:',
      ':rage3:',
      ':rage4:',
      ':suspect:',
      ':trollface:',
      ':sunny:',
      ':umbrella:',
      ':cloud:',
      ':snowflake:',
      ':snowman:',
      ':zap:',
      ':cyclone:',
      ':foggy:',
      ':ocean:',
      ':cat:',
      ':dog:',
      ':mouse:',
      ':hamster:',
      ':rabbit:',
      ':wolf:',
      ':frog:',
      ':tiger:',
      ':koala:',
      ':bear:',
      ':pig:',
      ':pig_nose:',
      ':cow:',
      ':boar:',
      ':monkey_face:',
      ':monkey:',
      ':horse:',
      ':racehorse:',
      ':camel:',
      ':sheep:',
      ':elephant:',
      ':panda_face:',
      ':snake:',
      ':bird:',
      ':baby_chick:',
      ':hatched_chick:',
      ':hatching_chick:',
      ':chicken:',
      ':penguin:',
      ':turtle:',
      ':bug:',
      ':honeybee:',
      ':ant:',
      ':beetle:',
      ':snail:',
      ':octopus:',
      ':tropical_fish:',
      ':fish:',
      ':whale:',
      ':whale2:',
      ':dolphin:',
      ':cow2:',
      ':ram:',
      ':rat:',
      ':water_buffalo:',
      ':tiger2:',
      ':rabbit2:',
      ':dragon:',
      ':goat:',
      ':rooster:',
      ':dog2:',
      ':pig2:',
      ':mouse2:',
      ':ox:',
      ':dragon_face:',
      ':blowfish:',
      ':crocodile:',
      ':dromedary_camel:',
      ':leopard:',
      ':cat2:',
      ':poodle:',
      ':paw_prints:',
      ':bouquet:',
      ':cherry_blossom:',
      ':tulip:',
      ':four_leaf_clover:',
      ':rose:',
      ':sunflower:',
      ':hibiscus:',
      ':maple_leaf:',
      ':leaves:',
      ':fallen_leaf:',
      ':herb:',
      ':mushroom:',
      ':cactus:',
      ':palm_tree:',
      ':evergreen_tree:',
      ':deciduous_tree:',
      ':chestnut:',
      ':seedling:',
      ':blossom:',
      ':ear_of_rice:',
      ':shell:',
      ':globe_with_meridians:',
      ':sun_with_face:',
      ':full_moon_with_face:',
      ':new_moon_with_face:',
      ':new_moon:',
      ':waxing_crescent_moon:',
      ':first_quarter_moon:',
      ':waxing_gibbous_moon:',
      ':full_moon:',
      ':waning_gibbous_moon:',
      ':last_quarter_moon:',
      ':waning_crescent_moon:',
      ':last_quarter_moon_with_face:',
      ':first_quarter_moon_with_face:',
      ':moon:',
      ':earth_africa:',
      ':earth_americas:',
      ':earth_asia:',
      ':volcano:',
      ':milky_way:',
      ':partly_sunny:',
      ':octocat:',
      ':squirrel:',
      ':bamboo:',
      ':gift_heart:',
      ':dolls:',
      ':school_satchel:',
      ':mortar_board:',
      ':flags:',
      ':fireworks:',
      ':sparkler:',
      ':wind_chime:',
      ':rice_scene:',
      ':jack_o_lantern:',
      ':ghost:',
      ':santa:',
      ':christmas_tree:',
      ':gift:',
      ':bell:',
      ':no_bell:',
      ':tanabata_tree:',
      ':tada:',
      ':confetti_ball:',
      ':balloon:',
      ':crystal_ball:',
      ':cd:',
      ':dvd:',
      ':floppy_disk:',
      ':camera:',
      ':video_camera:',
      ':movie_camera:',
      ':computer:',
      ':tv:',
      ':iphone:',
      ':phone:',
      ':telephone:',
      ':telephone_receiver:',
      ':pager:',
      ':fax:',
      ':minidisc:',
      ':vhs:',
      ':sound:',
      ':speaker:',
      ':mute:',
      ':loudspeaker:',
      ':mega:',
      ':hourglass:',
      ':hourglass_flowing_sand:',
      ':alarm_clock:',
      ':watch:',
      ':radio:',
      ':satellite:',
      ':loop:',
      ':mag:',
      ':mag_right:',
      ':unlock:',
      ':lock:',
      ':lock_with_ink_pen:',
      ':closed_lock_with_key:',
      ':key:',
      ':bulb:',
      ':flashlight:',
      ':high_brightness:',
      ':low_brightness:',
      ':electric_plug:',
      ':battery:',
      ':calling:',
      ':email:',
      ':mailbox:',
      ':postbox:',
      ':bath:',
      ':bathtub:',
      ':shower:',
      ':toilet:',
      ':wrench:',
      ':nut_and_bolt:',
      ':hammer:',
      ':seat:',
      ':moneybag:',
      ':yen:',
      ':dollar:',
      ':pound:',
      ':euro:',
      ':credit_card:',
      ':money_with_wings:',
      ':e-mail:',
      ':inbox_tray:',
      ':outbox_tray:',
      ':envelope:',
      ':incoming_envelope:',
      ':postal_horn:',
      ':mailbox_closed:',
      ':mailbox_with_mail:',
      ':mailbox_with_no_mail:',
      ':door:',
      ':smoking:',
      ':bomb:',
      ':gun:',
      ':hocho:',
      ':pill:',
      ':syringe:',
      ':page_facing_up:',
      ':page_with_curl:',
      ':bookmark_tabs:',
      ':bar_chart:',
      ':chart_with_upwards_trend:',
      ':chart_with_downwards_trend:',
      ':scroll:',
      ':clipboard:',
      ':calendar:',
      ':date:',
      ':card_index:',
      ':file_folder:',
      ':open_file_folder:',
      ':scissors:',
      ':pushpin:',
      ':paperclip:',
      ':black_nib:',
      ':pencil2:',
      ':straight_ruler:',
      ':triangular_ruler:',
      ':closed_book:',
      ':green_book:',
      ':blue_book:',
      ':orange_book:',
      ':notebook:',
      ':notebook_with_decorative_cover:',
      ':ledger:',
      ':books:',
      ':bookmark:',
      ':name_badge:',
      ':microscope:',
      ':telescope:',
      ':newspaper:',
      ':football:',
      ':basketball:',
      ':soccer:',
      ':baseball:',
      ':tennis:',
      ':8ball:',
      ':rugby_football:',
      ':bowling:',
      ':golf:',
      ':mountain_bicyclist:',
      ':bicyclist:',
      ':horse_racing:',
      ':snowboarder:',
      ':swimmer:',
      ':surfer:',
      ':ski:',
      ':spades:',
      ':hearts:',
      ':clubs:',
      ':diamonds:',
      ':gem:',
      ':ring:',
      ':trophy:',
      ':musical_score:',
      ':musical_keyboard:',
      ':violin:',
      ':space_invader:',
      ':video_game:',
      ':black_joker:',
      ':flower_playing_cards:',
      ':game_die:',
      ':dart:',
      ':mahjong:',
      ':clapper:',
      ':memo:',
      ':pencil:',
      ':book:',
      ':art:',
      ':microphone:',
      ':headphones:',
      ':trumpet:',
      ':saxophone:',
      ':guitar:',
      ':shoe:',
      ':sandal:',
      ':high_heel:',
      ':lipstick:',
      ':boot:',
      ':shirt:',
      ':tshirt:',
      ':necktie:',
      ':womans_clothes:',
      ':dress:',
      ':running_shirt_with_sash:',
      ':jeans:',
      ':kimono:',
      ':bikini:',
      ':ribbon:',
      ':tophat:',
      ':crown:',
      ':womans_hat:',
      ':mans_shoe:',
      ':closed_umbrella:',
      ':briefcase:',
      ':handbag:',
      ':pouch:',
      ':purse:',
      ':eyeglasses:',
      ':fishing_pole_and_fish:',
      ':coffee:',
      ':tea:',
      ':sake:',
      ':baby_bottle:',
      ':beer:',
      ':beers:',
      ':cocktail:',
      ':tropical_drink:',
      ':wine_glass:',
      ':fork_and_knife:',
      ':pizza:',
      ':hamburger:',
      ':fries:',
      ':poultry_leg:',
      ':meat_on_bone:',
      ':spaghetti:',
      ':curry:',
      ':fried_shrimp:',
      ':bento:',
      ':sushi:',
      ':fish_cake:',
      ':rice_ball:',
      ':rice_cracker:',
      ':rice:',
      ':ramen:',
      ':stew:',
      ':oden:',
      ':dango:',
      ':egg:',
      ':bread:',
      ':doughnut:',
      ':custard:',
      ':icecream:',
      ':ice_cream:',
      ':shaved_ice:',
      ':birthday:',
      ':cake:',
      ':cookie:',
      ':chocolate_bar:',
      ':candy:',
      ':lollipop:',
      ':honey_pot:',
      ':apple:',
      ':green_apple:',
      ':tangerine:',
      ':lemon:',
      ':cherries:',
      ':grapes:',
      ':watermelon:',
      ':strawberry:',
      ':peach:',
      ':melon:',
      ':banana:',
      ':pear:',
      ':pineapple:',
      ':sweet_potato:',
      ':eggplant:',
      ':tomato:',
      ':corn:',
      ':house:',
      ':house_with_garden:',
      ':school:',
      ':office:',
      ':post_office:',
      ':hospital:',
      ':bank:',
      ':convenience_store:',
      ':love_hotel:',
      ':hotel:',
      ':wedding:',
      ':church:',
      ':department_store:',
      ':european_post_office:',
      ':city_sunrise:',
      ':city_sunset:',
      ':japanese_castle:',
      ':european_castle:',
      ':tent:',
      ':factory:',
      ':tokyo_tower:',
      ':japan:',
      ':mount_fuji:',
      ':sunrise_over_mountains:',
      ':sunrise:',
      ':stars:',
      ':statue_of_liberty:',
      ':bridge_at_night:',
      ':carousel_horse:',
      ':rainbow:',
      ':ferris_wheel:',
      ':fountain:',
      ':roller_coaster:',
      ':ship:',
      ':speedboat:',
      ':boat:',
      ':sailboat:',
      ':rowboat:',
      ':anchor:',
      ':rocket:',
      ':airplane:',
      ':helicopter:',
      ':steam_locomotive:',
      ':tram:',
      ':mountain_railway:',
      ':bike:',
      ':aerial_tramway:',
      ':suspension_railway:',
      ':mountain_cableway:',
      ':tractor:',
      ':blue_car:',
      ':oncoming_automobile:',
      ':car:',
      ':red_car:',
      ':taxi:',
      ':oncoming_taxi:',
      ':articulated_lorry:',
      ':bus:',
      ':oncoming_bus:',
      ':rotating_light:',
      ':police_car:',
      ':oncoming_police_car:',
      ':fire_engine:',
      ':ambulance:',
      ':minibus:',
      ':truck:',
      ':train:',
      ':station:',
      ':train2:',
      ':bullettrain_front:',
      ':bullettrain_side:',
      ':light_rail:',
      ':monorail:',
      ':railway_car:',
      ':trolleybus:',
      ':ticket:',
      ':fuelpump:',
      ':vertical_traffic_light:',
      ':traffic_light:',
      ':warning:',
      ':construction:',
      ':beginner:',
      ':atm:',
      ':slot_machine:',
      ':busstop:',
      ':barber:',
      ':hotsprings:',
      ':checkered_flag:',
      ':crossed_flags:',
      ':izakaya_lantern:',
      ':moyai:',
      ':circus_tent:',
      ':performing_arts:',
      ':round_pushpin:',
      ':triangular_flag_on_post:',
      ':jp:',
      ':kr:',
      ':cn:',
      ':us:',
      ':fr:',
      ':es:',
      ':it:',
      ':ru:',
      ':gb:',
      ':uk:',
      ':de:',
      ':one:',
      ':two:',
      ':three:',
      ':four:',
      ':five:',
      ':six:',
      ':seven:',
      ':eight:',
      ':nine:',
      ':keycap_ten:',
      ':1234:',
      ':zero:',
      ':hash:',
      ':symbols:',
      ':arrow_backward:',
      ':arrow_down:',
      ':arrow_forward:',
      ':arrow_left:',
      ':capital_abcd:',
      ':abcd:',
      ':abc:',
      ':arrow_lower_left:',
      ':arrow_lower_right:',
      ':arrow_right:',
      ':arrow_up:',
      ':arrow_upper_left:',
      ':arrow_upper_right:',
      ':arrow_double_down:',
      ':arrow_double_up:',
      ':arrow_down_small:',
      ':arrow_heading_down:',
      ':arrow_heading_up:',
      ':leftwards_arrow_with_hook:',
      ':arrow_right_hook:',
      ':left_right_arrow:',
      ':arrow_up_down:',
      ':arrow_up_small:',
      ':arrows_clockwise:',
      ':arrows_counterclockwise:',
      ':rewind:',
      ':fast_forward:',
      ':information_source:',
      ':ok:',
      ':twisted_rightwards_arrows:',
      ':repeat:',
      ':repeat_one:',
      ':new:',
      ':top:',
      ':up:',
      ':cool:',
      ':free:',
      ':ng:',
      ':cinema:',
      ':koko:',
      ':signal_strength:',
      ':u5272:',
      ':u5408:',
      ':u55b6:',
      ':u6307:',
      ':u6708:',
      ':u6709:',
      ':u6e80:',
      ':u7121:',
      ':u7533:',
      ':u7a7a:',
      ':u7981:',
      ':sa:',
      ':restroom:',
      ':mens:',
      ':womens:',
      ':baby_symbol:',
      ':no_smoking:',
      ':parking:',
      ':wheelchair:',
      ':metro:',
      ':baggage_claim:',
      ':accept:',
      ':wc:',
      ':potable_water:',
      ':put_litter_in_its_place:',
      ':secret:',
      ':congratulations:',
      ':m:',
      ':passport_control:',
      ':left_luggage:',
      ':customs:',
      ':ideograph_advantage:',
      ':cl:',
      ':sos:',
      ':id:',
      ':no_entry_sign:',
      ':underage:',
      ':no_mobile_phones:',
      ':do_not_litter:',
      ':non-potable_water:',
      ':no_bicycles:',
      ':no_pedestrians:',
      ':children_crossing:',
      ':no_entry:',
      ':eight_spoked_asterisk:',
      ':eight_pointed_black_star:',
      ':heart_decoration:',
      ':vs:',
      ':vibration_mode:',
      ':mobile_phone_off:',
      ':chart:',
      ':currency_exchange:',
      ':aries:',
      ':taurus:',
      ':gemini:',
      ':cancer:',
      ':leo:',
      ':virgo:',
      ':libra:',
      ':scorpius:',
      ':sagittarius:',
      ':capricorn:',
      ':aquarius:',
      ':pisces:',
      ':ophiuchus:',
      ':six_pointed_star:',
      ':negative_squared_cross_mark:',
      ':a:',
      ':b:',
      ':ab:',
      ':o2:',
      ':diamond_shape_with_a_dot_inside:',
      ':recycle:',
      ':end:',
      ':on:',
      ':soon:',
      ':clock1:',
      ':clock130:',
      ':clock10:',
      ':clock1030:',
      ':clock11:',
      ':clock1130:',
      ':clock12:',
      ':clock1230:',
      ':clock2:',
      ':clock230:',
      ':clock3:',
      ':clock330:',
      ':clock4:',
      ':clock430:',
      ':clock5:',
      ':clock530:',
      ':clock6:',
      ':clock630:',
      ':clock7:',
      ':clock730:',
      ':clock8:',
      ':clock830:',
      ':clock9:',
      ':clock930:',
      ':heavy_dollar_sign:',
      ':copyright:',
      ':registered:',
      ':tm:',
      ':x:',
      ':heavy_exclamation_mark:',
      ':bangbang:',
      ':interrobang:',
      ':o:',
      ':heavy_multiplication_x:',
      ':heavy_plus_sign:',
      ':heavy_minus_sign:',
      ':heavy_division_sign:',
      ':white_flower:',
      ':100:',
      ':heavy_check_mark:',
      ':ballot_box_with_check:',
      ':radio_button:',
      ':link:',
      ':curly_loop:',
      ':wavy_dash:',
      ':part_alternation_mark:',
      ':trident:',
      ':black_square:',
      ':white_square:',
      ':white_check_mark:',
      ':black_square_button:',
      ':white_square_button:',
      ':black_circle:',
      ':white_circle:',
      ':red_circle:',
      ':large_blue_circle:',
      ':large_blue_diamond:',
      ':large_orange_diamond:',
      ':small_blue_diamond:',
      ':small_orange_diamond:',
      ':small_red_triangle:',
      ':small_red_triangle_down:',
      ':shipit:'
    ]

    emoji   = emoji_list[Math.floor(Math.random() * emoji_list.length)]
    emoji_2 = emoji_list[Math.floor(Math.random() * emoji_list.length)]
    emoji_3 = emoji_list[Math.floor(Math.random() * emoji_list.length)]

    black_cards = [
      "#{emoji} kid tested mother approved.",
      "#{emoji}: good to the last drop.",
      "#{emoji}? There's an app for that.",
      "#{emoji}. Betcha can't have just one.",
      "#{emoji}. High five bro.",
      "#{emoji}. It's a trap!",
      "#{emoji}. That's how I want to die.",
      "#{emoji} + #{emoji_2} = #{emoji_3}",
      "I went from #{emoji} to #{emoji_2}, all thanks to.",
      "#{emoji} and #{emoji_2} sitting in a tree. K-I-S-S-I-N-G.",
      "#{emoji} would be woefully incomplete without #{emoji_2}.",
      "#{emoji} is a slippery slope that leads to #{emoji_2}.",
      "An international tribunal has found #{emoji} guilty of #{emoji_2}.",
      "An the Academy Award for #{emoji} goes to #{emoji_2}.",
      "Before #{emoji}, all we had was #{emoji_2}.",
      "Dear Sir or Madam, We regret to inform you that the office of #{emoji} has denied your request for #{emoji_2}.",
      "For my next trick, I will pull #{emoji} out of #{emoji_2}.",
      "I never truly understood #{emoji} until I encountered #{emoji_2}.",
      "I spent my whole life working toward #{emoji}, only to have it ruined by #{emoji_2}.",
      "If God didn't want us to enjoy #{emoji}, he wouldn't have given us #{emoji_2}.",
      "In a pinch, #{emoji} can be a suitable substitute for #{emoji_2}.",
      "In a world ravaged by #{emoji}, our only solace is #{emoji_2}.",
      "In M. Night Shamalan's new movie, Bruce Willis discovers that #{emoji} had really been #{emoji_2} all along."
      "Lifetime presents #{emoji}, the story of #{emoji_2}.",
      "Michael Bay's new three-hour action epic pits #{emoji} against #{emoji_2}.",
      "Rumor has it that Vladimir Putin's favorite dish is – stuffed with #{emoji}.",
      "Step 1: #{emoji} Step 2: #{emoji_2} Step 3: Profit.",
      "That's right I killed #{emoji}. How you ask? #{emoji_2}.",
      "What's the next superhero/sidekick duo?",
      "When I was tripping on acid #{emoji} turned into #{emoji_2}.",
      "You haven't truly lived until you've experienced #{emoji} and #{emoji_2} at the same time.",
      "A romantic candlelit dinner would be incomplete without #{emoji}.",
      "After blacking out during New Year's Eve, I was awoken by #{emoji}.",
      "After months of debate, the Occupy Wall Street General Assembly could only agree on “More #{emoji}!”",
      "After the earthquake, Sean Penn bought #{emoji} to the people of Haiti.",
      "Alternative medicine is now embracing the curative powers of #{emoji}.",
      "And I would have gotten away with it, too, if it hadn't been for #{emoji}.",
      "Anthropologists have recently discovered a primitive tribe that worships #{emoji}.",
      "Before I run for president, I must destroy all evidence of my involvement with #{emoji}.",
      "BILLY MAYS HERE FOR #{emoji}.",
      "But before I kill you, Mr. Bond, I must show you #{emoji}.",
      "Charades was ruined for me forever when my mom had to act out #{emoji}.",
      "Coming to Broadway this season, #{emoji}: The Musical.",
      "Dear Abby, I'm having some trouble with #{emoji} and would like your advice.",
      "During his midlife crisis, my dad got really into #{emoji}.",
      "During Picasso's often-overlooked Brown Period, he produced hundreds of paintings of #{emoji}.",
      "During sex, I like to think about #{emoji}.",
      "Every Christmas my uncle gets drunk and tells the story about #{emoji}.",
      "Everyone down on the ground! We don't want to hurt anyone. We're just here for #{emoji}.",
      "He who controls #{emoji} controls the world.",
      "How am I maintaining my relationship status: #{emoji}.",
      "I do not know with what weapons World War III will be fought, but World War IV will be fought with #{emoji}.",
      "I drink to forget #{emoji}.",
      "I got 99 problems but #{emoji} ain't one.",
      "I learned the hard way that you can't cheer up a grieving friend with #{emoji}.",
      "I'm sorry professor, but I couldn't complete my homework because of #{emoji}.",
      "In 1,000 years when paper money is but a distant memory, #{emoji} will be our currency.",
      "In an attempt to reach a wider audience, the Smithsonian Museum of Natural History has opened an interactive exhibit on #{emoji}.",
      "In his new self-produced album, Kanye West raps over the sounds of #{emoji}.",
      "In his newest and most difficult stunt, David Blaine must escape from #{emoji}.",
      "In its new tourism campaign, Detroit proclaims that it has finally eliminated #{emoji}.",
      "In L.A. county Jail, word is you can trade 200 cigarettes for #{emoji}.",
      "In Michael Jackson's final moments, he thought about #{emoji}.",
      "In Rome, there are whisperings that the Vatican has a secret room devoted to #{emoji}.",
      "In the distant future, historians will agree that #{emoji} marked the beginning of America's decline.",
      "In the new Disney Channel Original Movie, Hannah Montana struggles with #{emoji} for the first time.",
      "Instead of coal, Santa now gives the bad children #{emoji} .",
      "It's a pity that kids these days are all getting involved with #{emoji}.",
      "Jesus is #{emoji}.",
      "Life for American Indians was forever changed when the White Man introduced them to #{emoji}.",
      "Little Miss Muffet, Sat on a tuffet, Eating her curds and #{emoji}.",
      "Major League Baseball has banned #{emoji} for giving players an unfair advantage.",
      "Maybe she's born with it. Maybe it's #{emoji}.",
      "Members of New York's social elite are paying thousands of dollars just to experience #{emoji}.",
      "MTV's new reality show features eight washed-up celebrities living with #{emoji}.",
      "My country, 'tis of thee, sweet land of #{emoji}.",
      "My mom freaked out when she looked at my browser history and found #{emoji}.com.",
      "My new favorite porn star is Joey “#{emoji}” McGee.",
      "Next from J.K. Rowling: Harry Potter and the Chamber of #{emoji}.",
      "Next on ESPN2: The World Series of #{emoji}.",
      "Next time on Dr. Phil: How to talk to your child about #{emoji}.",
      "On the third day of Christmas, my true love game to me: three French hens, two turtle doves, and #{emoji}.",
      "Only two things in life are certain: death and #{emoji}.",
      "Science will never explain the origin of #{emoji}.",
      "Studies show that lab rats navigate mazes 50% faster after being exposed to #{emoji}",
      "The CIA now interrogates enemy agents by repeatedly subjecting them to #{emoji}.",
      "The class field trip was completely ruined by #{emoji}.",
      "The Five Stages of Grief: denial, anger, bargaining, #{emoji} acceptance.",
      "The healing process began when I joined a support group for victims of #{emoji}.",
      "The socialist governments of Scandanavia have declared that access to – is a basic human right.",
      "The votes are in, and the new high school mascot is #{emoji}.",
      "This holiday season, Tim Allen must overcome his fear of #{emoji} to save Christmas.",
      "This is the way the world ends This is the way the world ends Not with a bang but with #{emoji}.",
      "This is your captain speaking. Fasten your seatbelts and prepare for #{emoji}.",
      "This month's Cosmo: 'Spice up your sex life by bringing #{emoji} into the bedroom.'",
      "This season on Man vs. Wild, Bear Grylls must survive in the depths of the Amazon with only #{emoji} and his wits.",
      "Tonight on 20/20: What you don't know about #{emoji} could kill you.",
      "TSA guidelines now prohibit #{emoji} on airplanes.",
      "Wake up, America. Christmas is under attack by secular liberals and their #{emoji}.",
      "War! What is it good for? #{emoji}.",
      "I am giving up #{emoji} for Lent.",
      "My parents are hiding #{emoji} from me.",
      "The #{emoji} brought the orgy to a grinding halt.",
      "I brought back a #{emoji} from Mexico.",
      "The US airdropped #{emoji} to the children of Afghanistan.",
      "Vin Diesel ate #{emoji} for dinner.",
      "Old people smell like #{emoji}.",
      "Dick Cheney prefers #{emoji}.",
      "You don't want to find #{emoji} in your Chinese food?",
      "My last relationship was ended by #{emoji}."
      "#{emoji} gets better with age.",
      "#{emoji} gives me uncontrollable gas.",
      "#{emoji} has been making life difficult at the nudist colony.",
      "#{emoji} helps Obama unwind.",
      "Batman's guilty pleasure is #{emoji}.",
      "#{emoji} keeps me warm during the cold, cold winter.",
      "#{emoji} never fails to liven up the party.",
      "#{emoji} will always get you laid.",
      "I bring #{emoji} back in time to convince people that I am a powerful wizard.",
      "Grandma finds #{emoji} disturbing, yet oddly charming.",
      "#{emoji} is a girl's best friend?",
      "#{emoji} is my anti-drug?",
      "#{emoji} is my secret power?",
      "Teach for America is using #{emoji} to inspire inner city students to succeed?",
      "That smell is #{emoji}",
      "That sound #{emoji}",
      "#{emoji} is the crustiest.",
      "#{emoji} is the gift that keeps on giving.",
      "#{emoji} is the most emo.",
      "#{emoji} is the new fad diet.",
      "#{emoji} is the next Happy Meal toy.",
      "There's a ton of #{emoji} in heaven.",
      "When all else fails, I can always masturbate to #{emoji}.",
      "When I am a billionaire, I shall erect a 50-foot statue to commemorate #{emoji}.",
      "When I am President of the United States, I will create the Department of #{emoji}.",
      "When I pooped, #{emoji} came out of my butt?",
      "When Pharaoh remained unmoved, Moses called down a Plague of #{emoji}.",
      "When the United States raced the Soviet Union to the moon, the Mexican government funneled millions of pesos into research on #{emoji}.",
      "I am sticky because #{emoji}.",
      "I can't sleep at night because #{emoji}.",
      "I hurt all over because #{emoji}."
    ]

    msg.send black_cards[Math.floor(Math.random() * black_cards.length)]

