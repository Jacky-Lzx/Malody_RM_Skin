--Rhythm Master Skin for Malody V
--Lua by dreamcat
--Edited by Lzx

-- Word Explanation:
--  "Composer": the editor of the skin in Malody V

-- 皮肤初始化时被调用
function Init()
    -- Require version greater than 5.4.62
    local angle = Game:FieldMeta("Angle")

    local width = Game:Width()
    local audio_length = Game:AudioLength()

    local scale = Game:FieldMeta("Scale")
    local note_scale
    if (scale <= 0.95) then
        note_scale = 0.9
    elseif (scale > 0.95 and scale <= 1.05) then
        note_scale = 1
    elseif (scale > 1.05 and scale <= 1.15) then
        note_scale = 1.1
    else
        note_scale = 1.2
    end

    local scale_width
    local original_height
    if (width >= 1680) then
        scale_width = 1
        original_height = 1080
    else
        scale_width = width / 1680
        original_height = 1080 / scale_width
    end

    local sw1610
    if (width >= 1728) then
        sw1610 = 1
    else
        sw1610 = width / 1728
    end

    local topwidth = { 760, 732, 704, 674, 646, 616, 588, 558, 528, 498, 468, 438, 408, 376, 346, 314, 282, 250, 218, 184, 150 }
    local topheight = {}
    local toptan = {}
    local imgtrackbgtan = 632 / 866
    for i = 1, 21 do
        topheight[i] = 840 / (840 - topwidth[i] / 2) * 920
        toptan[i] = 840 * scale / (topheight[i] + (original_height / 2 - 380) * (1 - scale))
    end

    local trackbg = Module:Find("trackbg")
    trackbg.Width = 2680 * scale * scale_width
    trackbg.Height = 1608 * scale * scale_width * imgtrackbgtan / toptan[angle - 29]
    trackbg.Y = (original_height / 2 - 380) * scale * scale_width - trackbg.Height / 1608 * 601


    local hp_background = Module:Find("hpbg")
    hp_background.Width = width
    hp_background.Height = 135 * sw1610

    local hp = Module:Find("hp")
    hp.Width = 498.1 * sw1610
    hp.Height = 47.8 * sw1610
    hp.X = 35 * sw1610
    hp.Y = -60 * sw1610

    local score_background = Module:Find("scorebg")
    score_background.Width = 529.9 * sw1610
    score_background.Height = 104 * sw1610
    score_background.X = width / 2
    score_background.Y = -29 * sw1610

    local pause = Module:Find("pause")
    pause.Width = 34 * sw1610
    pause.Height = 41 * sw1610
    pause.X = width / 2 - 50 * sw1610
    pause.Y = -80 * sw1610

    local score = Module:Find("score")
    score.ScaleX = sw1610
    score.ScaleY = sw1610
    score.X = width / 2 - 120 * sw1610
    score.Y = -79 * sw1610

    local acc_background = Module:Find("accbg")
    acc_background.Width = 600 * sw1610
    acc_background.Height = 84 * sw1610
    acc_background.X = width / 2 - 380 * sw1610
    acc_background.Y = -130 * sw1610

    local progress = Module:Find("progress")
    progress.Y = -10 * sw1610
    progress.Width = 20
    progress:DoWidth({ start = 0, finish = audio_length, from = 20, to = width + 20 })

    if (width >= 2120) then
        score_background.X = 1060
        pause.X = 1010
        score.X = 940
        acc_background.X = 680
    end

    -- key 1-4: unpressed key skins
    -- key 5-8: pressed key skins (Controlled in Composer)
    -- key 9-12: pressed key skins (Used for the fade-out effect) (key 1 corresponds to key 9)
    Module_keys = {}
    for i = 1, 12 do
        local key = Module:Find("key" .. i)
        -- Set the size of all keys
        key.Height = 6.48 / note_scale
        key.Y = -0.9 / note_scale
        -- Since we only use key 9-12, we directly store them in 1-4 of Module_keys
        if (i >= 9) then
            Module_keys[i - 8] = key
        end
    end

    local trackbottom = Module:Find("trackbottom")
    trackbottom.Height = 21.6 / note_scale
    trackbottom.Y = -7.2 / note_scale

    local track_line = {}
    for i = 1, 3 do
        track_line[i] = Module:Find("trackline" .. i)
        track_line[i].Y = 2.7 / note_scale
        track_line[i].Height = 360 / note_scale
    end

    local bpm = {}
    local p = Game:BpmCount()
    for i = 1, p do
        bpm[i] = Game:BpmAt(i - 1)
    end
    bpm[p + 1] = { time = 5000000 }
    for i = 1, p do
        score:DoAlpha({
            start = bpm[i].time,
            finish = bpm[i].time + 60000 / bpm[i].bpm,
            from = 100,
            to = 60,
            repeats = (bpm[i + 1].time - bpm[i].time) /
                60000 * bpm[i].bpm // 1 + 1
        })
    end

    Offset_indicator = Module:Find("indicator")
    local offset_blue = Module:Find("offblue")
    local offset_green = Module:Find("offgreen")
    local offset_yellow = Module:Find("offyellow")
    local offset_bar = Module:Find("offbar")

    local mod = Module:Find("mod")
    local modtext = mod.Text
    local mod_str = {}
    for v in string.gmatch(modtext, "[%a+]+") do
        table.insert(mod_str, v)
    end

    local judge_type = { "HARD", "NORMAL+", "NORMAL", "EASY+", "EASY" }

    local value_best
    local value_cool
    local value_good
    Rush_value = 1.0
    for i = 1, #mod_str do
        for k = 1, #judge_type do
            if (mod_str[i] == judge_type[k]) then
                if (k <= 3) then
                    -- These values are inconsistent with the values in https://zh.moegirl.org.cn/zh/Malody
                    -- But it is consistent with the offset value in the game (my experiment)
                    value_best = 20 + 8 * k
                    value_cool = 60 + 8 * k
                    value_good = 105 + 8 * k
                else
                    value_best = 44 + 10 * (k - 3)
                    value_cool = 84 + 10 * (k - 3)
                    value_good = 129 + 10 * (k - 3)
                end
            end
        end

        if (mod_str[i] == "Dash") then
            Rush_value = 1.2
        elseif (mod_str[i] == "Rush") then
            Rush_value = 1.5
        elseif (mod_str[i] == "Slow") then
            Rush_value = 0.8
        else
            Rush_value = 1
        end
    end

    offset_blue.Width = 3 * value_best / Rush_value
    offset_green.Width = 3 * value_cool / Rush_value
    offset_yellow.Width = 3 * value_good / Rush_value
    offset_bar.Width = 3 * value_good / Rush_value + 40
end

function OnRetry()
end

-- 每一帧调用。函数为空时删除函数
function Update()
end

-- 玩家操作时调用，按键，抬起等。函数为空时删除函数
-- 在Composer中不会被调用
function OnInput()
    local input_event = Game:InputEvent()
    local input_x = input_event:HitX()
    local input_type = input_event:Type()
    local time = Game:Time()

    -- Pressing event is handled in the Composer

    -- Releasing event is handled here
    if (input_type == 3) then -- Release the key
        Module_keys[input_x]:DoAlpha({ start = time, finish = time + 450, from = 100, to = 0 })
    end
end

-- 玩家击打时调用。函数为空时删除函数
-- 在Composer中不会被调用
function OnHit()
    local time = Game:Time()
    local hit_event = Game:HitEvent()
    local offset = hit_event:Offset() -- offset > 0: early; offset < 0: late
    -- judge_result
    --   0: Ignore
    --   1: Best
    --   2: Cool
    --   3: Good
    --   4: Miss
    local judge_result = hit_event:JudgeResult()

    -- Animation: early or late
    if (judge_result == 2 or judge_result == 3) then
        if (offset < 0) then
            Module:Find("slow"):DoAlpha({ start = time, finish = time + 300, from = 100, to = 0 });
        else
            Module:Find("fast"):DoAlpha({ start = time, finish = time + 300, from = 100, to = 0 });
        end
    end

    -- Animation: offset
    if (judge_result == 1 or judge_result == 2 or judge_result == 3) then
        local offset_perfect = Module:Find("offp")
        local offset_cool = Module:Find("offg")
        local offset_good = Module:Find("offm")
        local shadow_types = { offset_perfect, offset_cool, offset_good } -- Indexed by judge_result

        local offset_shadow = Module:Shadow(shadow_types[judge_result], 3000)
        local offset_x = offset * -1.5 / Rush_value
        local offset_animation = { p1 = 0.6, p2 = 0, p3 = 0.4, p4 = 0 }

        offset_shadow.X = offset_x
        offset_shadow:DoAlpha({
            start = time,
            finish = time + 3000,
            from = 100,
            to = 0,
            custom = offset_animation
        })

        local indicator_x = Offset_indicator.X
        Offset_indicator:DoMoveX({ start = time, finish = time + 500, from = indicator_x, to = offset_x, ease = 2 })
    end
end
