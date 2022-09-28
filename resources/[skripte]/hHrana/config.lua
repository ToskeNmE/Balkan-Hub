Config = {}

--v1.0


--Main
Config.Locale = 'en'
Config.ItemTester = 'alcotester' -- Item for alcohol tester
Config.Status = true -- if you use esx_status, type true and for food and drink you can set how much it will gain when you bite into the food
-- if you have Config.Status = true then turn off esx_basicneeds


--Food
Config.EatButton = 38
Config.FoodThrow = 105
Config.ServeFood = 10
Config.FoodSmallRemove = {min = 17, max = 30} -- this is a random removal of g when biting into food below 100 g
Config.FoodBigRemove = {min = 30, max = 50} -- this is an accidental removal of g when biting into food over 100 g

Config.Food = {
    {Item = "burger",  Label = 'Hamburger', g = 220, Prop = "prop_cs_burger_01", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = -50.0, Pos5 = 16.0, Pos6 = 60.0}, --G this is grams
    {Item = "meteorite", Label = 'Meteorite', g = 80, Prop = "prop_choc_meto", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 50.0, Pos5 = 30.0, Pos6 = 260.0},
    {Item = "hotdog",  Label = 'Hotdog', g = 120, Prop = "prop_cs_hotdog_01", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 0.0, Pos5 = -140.0, Pos6 = -140.0},
    {Item = "taco",  Label = 'Taco', g = 180, Prop = "prop_taco_01", StatusHunger = 50000, Pos1 = 0.13, Pos2 = 0.05, Pos3 = 0.02, Pos4 = 0.0, Pos5 = -140.0, Pos6 = -140.0},
}


-- Drink
Config.DrinkingButton = 38
Config.DrinkThrowButton = 105
Config.ServeDrink = 10
Config.SplitDrinkButton = 317
Config.CleanUpItem = 317
Config.DrinkSmallRemove = {min = 17, max = 30} -- it is an accidental removal of ml when drinking below 100 ml
Config.DrinkBigRemove = {min = 35, max = 80} -- it is an accidental removal of ml when drinking above 100 ml


Config.Drink = {
    -- ITEM = spawn code -- CleanUpItem = This is an item that you get after inserting the shot into the inventory -- ml = item content -- prop = the code of the item you are holding in your hands -- StatusDrink = this is for esx_status
   -- thirst is added after each click of the Drink button -- Alcohol = How much effect is added after one click on the Drink button -- Shots = true if you want to pour shots from the bottle -- pos = prop position
    {Item = "piswasser",  CleanUpItem = '', ml = 500, Prop = "prop_amb_beer_bottle", StatusDrink = 10000, Alcohol = 0.0359949, Shots = false , Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.01, Pos4 = 18.0, Pos5 = -10.0, Pos6 = 0.0},

    {Item = "mount_whisky",  CleanUpItem = 'shot_mount_whisky', ml = 500, Prop = "prop_whiskey_bottle", StatusDrink = 10000, Alcohol = 0.0759949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.17, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},
     
    {Item = "tequila",  CleanUpItem = 'shot_tequila', ml = 500, Prop = "prop_tequila_bottle", StatusDrink = 10000, Alcohol = 0.0959949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.23, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},

    {Item = "nogo_vodka",  CleanUpItem = 'shot_nogo_vodka', ml = 500, Prop = "prop_vodka_bottle", StatusDrink = 10000, Alcohol = 0.0859949, Shots = true, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},

    {Item = "raine",  CleanUpItem = '', ml = 250, Prop = "ba_prop_club_water_bottle", StatusDrink = 10000, Alcohol = 0.0, Shots = false, Pos1 = 0.02, Pos2 = -0.01, Pos3 = -0.14, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},

    {Item = "bean_machine_coffe",  CleanUpItem = '', ml = 250, Prop = "p_ing_coffeecup_01", StatusDrink = 10000, Alcohol = 0.0, Shots = false, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.02, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 0.0},

    {Item = "sprunk",  CleanUpItem = '', ml = 330, Prop = "v_res_tt_can03", StatusDrink = 10000, Alcohol = 0.0, Shots = false, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.02, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 0.0},

    {Item = "cola",  CleanUpItem = '', ml = 330, Prop = "prop_ecola_can", StatusDrink = 10000, Alcohol = 0.0, Shots = false, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.02, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 0.0},

    {Item = "water",  CleanUpItem = '', ml = 500, Prop = "prop_ld_flow_bottle", StatusDrink = 10000, Alcohol = 0.0, Shots = false, Pos1 = 0.01, Pos2 = 0.0, Pos3 = -0.07, Pos4 = 1.0, Pos5 = 1.0, Pos6 = 0.0},
}

--SHOTS
Config.DrinkShot = { --we recommend leaving 30 ml for a shot
    {Item = "shot_mount_whisky",  Label = 'Casa Mount Viski', mlshot = 30, StatusDrink = 10000, Alcohol = 0.0759949},

    {Item = "shot_nogo_vodka",  Label = 'Casa Nogo Vodka', mlshot = 30, StatusDrink = 10000, Alcohol = 0.0859949},
     
    {Item = "shot_tequila",  Label = 'Casa Tequilya', mlshot = 30, StatusDrink = 10000, Alcohol = 0.0959949},
}


--WINE
Config.Wine = {
    {Item = "costa_del_perro",  CleanUpItem = 'glass_costa_del_perro', ml = 500, Prop = "prop_wine_bot_01", Alcohol = 0.0759949, StatusDrink = 10000, Pos1 = 0.02, Pos2 = -0.009, Pos3 = -0.26, Pos4 = 05.0, Pos5 = -10.0, Pos6 = 25.0},

    {Item = "rockford_hill",  CleanUpItem = 'glass_rockford_hill', ml = 500, Prop = "prop_wine_bot_02", Alcohol = 0.0759949, StatusDrink = 10000, Pos1 = 0.0, Pos2 = -0.01, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -03.0, Pos6 = 0.0},
     
    {Item = "vinewood_red",  CleanUpItem = 'glass_vinewood_red', ml = 500, Prop = "prop_wine_rose", Alcohol = 0.0759949, StatusDrink = 10000, Pos1 = 0.0, Pos2 = -0.009, Pos3 = -0.29, Pos4 = 0.2, Pos5 = -06.0, Pos6 = 0.0},

    {Item = "vinewood_blanc",  CleanUpItem = 'glass_vinewood_blanc', ml = 500, Prop = "prop_wine_white", Alcohol = 0.0759949, StatusDrink = 10000, Pos1 = 0.0, Pos2 = -0.02, Pos3 = -0.28, Pos4 = 0.2, Pos5 = -03.0, Pos6 = 0.0},

}

Config.WineGlass = { --we recommend leaving 100 ml for a wine glass
    {Item = "glass_costa_del_perro",  Label = 'Casa Costa Del Perro', mlwine = 100, Alcohol = 0.0759949, StatusDrink = 10000},

    {Item = "glass_rockford_hill",  Label = 'Casa Rockford Hill Reserve', mlwine = 100, Alcohol = 0.0759949, StatusDrink = 10000},
     
    {Item = "glass_vinewood_red",  Label = 'Casa Vinewood Red Zinfadel', mlwine = 100, Alcohol = 0.0759949, StatusDrink = 10000},

    {Item = "glass_vinewood_blanc",  Label = 'Casa Vinewood Sauvignon Blanc', mlwine = 100, Alcohol = 0.0759949, StatusDrink = 10000},
}