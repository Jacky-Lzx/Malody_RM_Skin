--Rhythm Master Skin for Malody V
--Lua by dreamcat
--Edited by Lzx
function Init()
    -- Require version greater than 5.4.62
    angle = Game:FieldMeta("Angle")

    width = Game:Width()
    audio_length = Game:AudioLength()

    judge_size = Module:GetNumber("Judge Size (0.6-1.4)")
    if (judge_size < 0.6 or judge_size > 1.4) then
        judge_size = 1
    end

    scale = Game:FieldMeta("Scale")
    if (scale <= 0.95) then
        note_scale = 0.9
    elseif (scale > 0.95 and scale <= 1.05) then
        note_scale = 1
    elseif (scale > 1.05 and scale <= 1.15) then
        note_scale = 1.1
    else
        note_scale = 1.2
    end

    if (width >= 1680) then
        scale_width = 1
        original_height = 1080
    else
        scale_width = width / 1680
        original_height = 1080 / scale_width
    end

    if (width >= 1728) then
        sw1610 = 1
    else
        sw1610 = width / 1728
    end

    topwidth = { 760, 732, 704, 674, 646, 616, 588, 558, 528, 498, 468, 438, 408, 376, 346, 314, 282, 250, 218, 184, 150 }
    topheight = {}
    toptan = {}
    imgtrackbgtan = 632 / 866
    for i = 1, 21 do
        topheight[i] = 840 / (840 - topwidth[i] / 2) * 920
        toptan[i] = 840 * scale / (topheight[i] + (original_height / 2 - 380) * (1 - scale))
    end
    trackbg = Module:Find("trackbg")
    trackbg.Width = 2680 * scale * scale_width
    trackbg.Height = 1608 * scale * scale_width * imgtrackbgtan / toptan[angle - 29]
    trackbg.Y = (original_height / 2 - 380) * scale * scale_width - trackbg.Height / 1608 * 601

    -- tracklight = {}
    -- for i = 1, 2 do
    --     tracklight[i] = Module:Find("tracklight" .. i)
    --     tracklight[i].Width = 960.512 * scale * scale_width
    --     tracklight[i].Height = 1260.672 * scale * scale_width * imgtrackbgtan / toptan[angle - 29]
    --     tracklight[i].Y = trackbg.Y
    -- end
    -- tracklight[1].X = -379.488 * scale * scale_width
    -- tracklight[2].X = 379.488 * scale * scale_width

    -- Set the slow and fast indicator to transparent at the beginning
    slow = Module:Find("slow")
    fast = Module:Find("fast")
    slow.Alpha = 0
    fast.Alpha = 0

    combo = Module:Find("combo")
    mjudge = Module:Find("judge")
    luaacc = Module:Find("luaacc")
    accvalue = 0
    luaaccvalue = 0

    hpbg = Module:Find("hpbg")
    hpbg.Width = width
    hpbg.Height = 135 * sw1610

    hp = Module:Find("hp")
    hp.Width = 498.1 * sw1610
    hp.Height = 47.8 * sw1610
    hp.X = 35 * sw1610
    hp.Y = -60 * sw1610

    scorebg = Module:Find("scorebg")
    scorebg.Width = 529.9 * sw1610
    scorebg.Height = 104 * sw1610
    scorebg.X = width / 2
    scorebg.Y = -29 * sw1610

    pause = Module:Find("pause")
    pause.Width = 34 * sw1610
    pause.Height = 41 * sw1610
    pause.X = width / 2 - 50 * sw1610
    pause.Y = -80 * sw1610

    score = Module:Find("score")
    score.ScaleX = sw1610
    score.ScaleY = sw1610
    score.X = width / 2 - 120 * sw1610
    score.Y = -79 * sw1610

    accbg = Module:Find("accbg")
    accbg.Width = 600 * sw1610
    accbg.Height = 84 * sw1610
    accbg.X = width / 2 - 380 * sw1610
    accbg.Y = -130 * sw1610

    acc = Module:Find("acc")
    acc.ScaleX = sw1610
    acc.ScaleY = sw1610
    acc.X = width / 2 - 100 * sw1610
    acc.Y = -172 * sw1610
    acc.Text = "0.00"

    progress = Module:Find("progress")
    progress.Y = -10 * sw1610
    progress.Width = 20
    progress:DoWidth({ start = 0, finish = audio_length, from = 20, to = width + 20 })

    if (width >= 2120) then
        scorebg.X = 1060
        pause.X = 1010
        score.X = 940
        accbg.X = 680
        acc.X = 960
    end

    perfect_effect = Module:Find("perfecteffect")
    -- mhit = {}
    -- for i = 1, 6 do
    --     mhit[i] = Module:Find("hit" .. i)
    --     mhit[i].RotateX = angle
    --     mhit[i].Width = 56.9 / (note_scale ^ 0.5)
    --     mhit[i].Height = 56.9 / (note_scale ^ 0.5)
    -- end

    mkey = {}
    for i = 1, 12 do
        mkey[i] = Module:Find("key" .. i)
        mkey[i].Height = 6.48 / note_scale
        mkey[i].Y = -0.9 / note_scale
    end

    trackbottom = Module:Find("trackbottom")
    trackbottom.Height = 21.6 / note_scale
    trackbottom.Y = -7.2 / note_scale

    track_line = {}
    for i = 1, 3 do
        track_line[i] = Module:Find("trackline" .. i)
        track_line[i].Y = 2.7 / note_scale
        track_line[i].Height = 360 / note_scale
    end

    bpm = {}
    p = Game:BpmCount()
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
        -- for k = 1, 2 do
        --     tracklight[k]:DoAlpha({
        --         start = bpm[i].time,
        --         finish = bpm[i].time + 60000 / bpm[i].bpm,
        --         from = 100,
        --         to = 0,
        --         repeats = (bpm[i + 1].time - bpm[i].time) /
        --             60000 * bpm[i].bpm // 1 + 1
        --     })
        -- end
    end

    offset_indicator = Module:Find("indicator")
    offset_blue = Module:Find("offblue")
    offset_green = Module:Find("offgreen")
    offset_yellow = Module:Find("offyellow")
    offset_perfect = Module:Find("offp")
    offset_cool = Module:Find("offg")
    offset_good = Module:Find("offm")
    offset_bar = Module:Find("offbar")

    mod = Module:Find("mod")
    modtext = mod.Text
    mod_str = {}
    judge_type = { "HARD", "NORMAL+", "NORMAL", "EASY+", "EASY" }
    judge_type_index = 0
    projudge = 0
    for v in string.gmatch(modtext, "[%a+]+") do
        table.insert(mod_str, v)
    end
    for i = 1, #mod_str do
        for k = 1, #judge_type do
            if (mod_str[i] == judge_type[k]) then
                judge_type_index = k
                if (k <= 3) then
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
            rush_value = 1.2
        elseif (mod_str[i] == "Rush") then
            rush_value = 1.5
        elseif (mod_str[i] == "Slow") then
            rush_value = 0.8
        else
            rush_value = 1
        end
    end

    offset_blue.Width = 3 * value_best / rush_value
    offset_green.Width = 3 * value_cool / rush_value
    offset_yellow.Width = 3 * value_good / rush_value
    offset_bar.Width = 3 * value_good / rush_value + 40
    soffani = { p1 = 0.6, p2 = 0, p3 = 0.4, p4 = 0 }
    inr = { 3, 3, 3, 3 }
end

function OnRetry()
    inr = { 3, 3, 3, 3 }
    accvalue = 0
    luaaccvalue = 0
    acc.Text = "0.00"
    offset_indicator.X = 0
end

function Update()
    luaaccvalue = tonumber(tonumber(string.match(luaacc.Text, "[%d.]+")))
    if (accvalue ~= luaaccvalue) then
        accvalue = luaaccvalue
        acc.Text = string.format("%.2f", accvalue)
    end
end

function OnInput()
    input_event = Game:InputEvent()
    input_x = input_event:HitX()
    input_type = input_event:Type()
    for i = 1, 4 do
        if (input_x == i) then
            inr[i] = input_type
        end
    end
    for i = 1, 4 do
        if (input_x == i) then
            if (inr[i] == 3) then
                local time = Game:Time()
                mkey[i + 8]:DoAlpha({ start = time, finish = time + 450, from = 100, to = 0 })
            end
        end
    end
end

local function animation_early_or_late(judge_result, offset, time)
    if (judge_result == 2 or judge_result == 3) then
        -- local offset = hit_event:Offset() -- offset > 0: early; offset < 0: late
        if (offset < 0) then
            slow:DoAlpha({ start = time, finish = time + 300, from = 100, to = 0 });
        else
            fast:DoAlpha({ start = time, finish = time + 300, from = 100, to = 0 });
        end
    end
end

local function animation_offset_indicator(judge_result, offset, rush_value, time, offset_indicator)
    if (judge_result == 1 or judge_result == 2 or judge_result == 3) then
        indicvalue = offset * -1.5 / rush_value
        dicx = offset_indicator.X
        offset_indicator:DoMoveX({ start = time, finish = time + 500, from = dicx, to = indicvalue, ease = 2 })
    end
end

function OnHit()
    local time = Game:Time()
    local hit_event = Game:HitEvent()
    local offset = hit_event:Offset()

    -- judge_result
    --   0: Ignore
    --   1: Best
    --   2: Cool
    --   3: Good
    --   4: Miss
    local judge_result = hit_event:JudgeResult()

    if (judge_result ~= 4) then
        combo:DoMoveY({ start = time, finish = time + 100 * rush_value, from = 120, to = 150, ease = 2 })
    end

    if (judge_result == 1 or judge_result == 2 or judge_result == 3 or judge_result == 4) then
        if (judge_result == 1) then
            perfect_effect:DoResize(
                { start = time, finish = time + 100 * rush_value, from = 588 * judge_size, to = 840 * judge_size },
                { start = time, finish = time + 100 * rush_value, from = 196.7 * judge_size, to = 281 * judge_size }
            )
            perfect_effect:DoAlpha({ start = time, finish = time + 400 * rush_value, from = 100, to = 0, custom = { p1 = 0.43, p2 = 0, p3 = 0.17, p4 = -0.11 } })
        end
        mjudge:DoResize(
            { start = time, finish = time + 100 * rush_value, from = 254.8 * judge_size, to = 364 * judge_size },
            { start = time, finish = time + 100, from = 44.8 * judge_size, to = 64 * judge_size })
        mjudge:DoAlpha({ start = time, finish = time + 600 * rush_value, from = 100, to = 0, custom = { p1 = 0.86, p2 = 0, p3 = 0.59, p4 = -0.11 } })
    end

    animation_offset_indicator(judge_result, offset, rush_value, time, offset_indicator)

    animation_early_or_late(judge_result, offset, time)

    if (judge_result == 1 or judge_result == 2 or judge_result == 3) then
        local shadow_types = { offset_perfect, offset_cool, offset_good } -- Indexed by judge_result
        local offset_shadow = Module:Shadow(shadow_types[judge_result], 3000)
        offset_shadow.X = offset * -1.5 / rush_value
        if (judge_result == 1) then
            -- Best
            offset_shadow:DoAlpha({
                start = time,
                finish = time + 3000 * rush_value,
                from = 100 - math.abs(offset) / 2,
                to = 0,
                custom = soffani
            })
        elseif (judge_result == 2) then
            -- Cool
            offset_shadow:DoAlpha({
                start = time,
                finish = time + 1000 * rush_value,
                from = 100 - math.abs(offset) / 2,
                to = 0,
                custom = soffani
            })
            if (projudge ~= 1) then
                for i = 1, 5 do
                    if (judge_type_index == i) then
                        if (i <= 3) then
                            coolpro = 20 + 8 * i
                        else
                            coolpro = 44 + 10 * (i - 3)
                        end
                        if (math.abs(offset) < coolpro) then
                            projudge = 1
                            local value_best = value_best - 9
                            local value_cool = value_cool - 9
                            local value_good = value_good - 20
                            offset_blue.Width = 3 * value_best / rush_value
                            offset_green.Width = 3 * value_cool / rush_value
                            offset_yellow.Width = 3 * value_good / rush_value
                        end
                    end
                end
            end
        elseif (judge_result == 3) then
            -- Good
            offset_shadow:DoAlpha({
                start = time,
                finish = time + 1000 * rush_value,
                from = 100 - math.abs(offset) / 2,
                to = 0,
                custom = soffani
            })
            if (projudge ~= 1) then
                for i = 1, 5 do
                    if (judge_type_index == i) then
                        if (i <= 3) then
                            goodpro = 60 + 8 * i
                        else
                            goodpro = 84 + 10 * (i - 3)
                        end
                        if (math.abs(offset) < goodpro) then
                            projudge = 1
                            local value_best = value_best - 9
                            local value_cool = value_cool - 9
                            local value_good = value_good - 20
                            offset_blue.Width = 3 * value_best / rush_value
                            offset_green.Width = 3 * value_cool / rush_value
                            offset_yellow.Width = 3 * value_good / rush_value
                        end
                    end
                end
            end
        end
    end
end
