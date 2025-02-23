--Rhythm Master Skin for Malody V
--Lua by dreamcat
--Edited by Lzx
function Init()
    bool5462 = Game:IsVersionGE(5, 4, 62)
    if (bool5462 == true) then
        angle = Game:FieldMeta("Angle")
        ss = Game:FieldMeta("Scale")
    else
        angle = Game:TrackAngle()
        ss = Game:SceneScale()
    end
    width = Game:Width()
    endtime = Game:AudioLength()
    judgesize = Module:GetNumber("Judge Size (0.6-1.4)")
    if (judgesize < 0.6 or judgesize > 1.4) then
        judgesize = 1
    end
    if (ss <= 0.95) then
        ns = 0.9
    elseif (ss > 0.95 and ss <= 1.05) then
        ns = 1
    elseif (ss > 1.05 and ss <= 1.15) then
        ns = 1.1
    else
        ns = 1.2
    end
    if (width >= 1680) then
        sw = 1
        oh = 1080
    else
        sw = width / 1680
        oh = 1080 / sw
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
        toptan[i] = 840 * ss / (topheight[i] + (oh / 2 - 380) * (1 - ss))
    end
    trackbg = Module:Find("trackbg")
    trackbg.Width = 2680 * ss * sw
    trackbg.Height = 1608 * ss * sw * imgtrackbgtan / toptan[angle - 29]
    trackbg.Y = (oh / 2 - 380) * ss * sw - trackbg.Height / 1608 * 601
    tracklight = {}
    for i = 1, 2 do
        tracklight[i] = Module:Find("tracklight" .. i)
        tracklight[i].Width = 960.512 * ss * sw
        tracklight[i].Height = 1260.672 * ss * sw * imgtrackbgtan / toptan[angle - 29]
        tracklight[i].Y = trackbg.Y
    end
    tracklight[1].X = -379.488 * ss * sw
    tracklight[2].X = 379.488 * ss * sw
    mcombo = Module:Find("combo")
    mjudge = Module:Find("judge")
    hpbg = Module:Find("hpbg")
    hp = Module:Find("hp")
    scorebg = Module:Find("scorebg")
    pause = Module:Find("pause")
    score = Module:Find("score")
    progress = Module:Find("progress")
    accbg = Module:Find("accbg")
    acc = Module:Find("acc")
    luaacc = Module:Find("luaacc")
    accvalue = 0
    luaaccvalue = 0
    hpbg.Width = width
    hpbg.Height = 135 * sw1610
    hp.Width = 498.1 * sw1610
    hp.Height = 47.8 * sw1610
    hp.X = 35 * sw1610
    hp.Y = -60 * sw1610
    scorebg.Width = 529.9 * sw1610
    scorebg.Height = 104 * sw1610
    scorebg.X = width / 2
    scorebg.Y = -29 * sw1610
    pause.Width = 34 * sw1610
    pause.Height = 41 * sw1610
    pause.X = width / 2 - 50 * sw1610
    pause.Y = -80 * sw1610
    score.ScaleX = sw1610
    score.ScaleY = sw1610
    score.X = width / 2 - 120 * sw1610
    score.Y = -79 * sw1610
    accbg.Width = 600 * sw1610
    accbg.Height = 84 * sw1610
    accbg.X = width / 2 - 380 * sw1610
    accbg.Y = -130 * sw1610
    acc.ScaleX = sw1610
    acc.ScaleY = sw1610
    acc.X = width / 2 - 100 * sw1610
    acc.Y = -172 * sw1610
    acc.Text = "0.00"
    progress.Y = -10 * sw1610
    progress.Width = 20
    progress:DoWidth({ start = 0, finish = endtime, from = 20, to = width + 20 })
    if (width >= 2120) then
        scorebg.X = 1060
        pause.X = 1010
        score.X = 940
        accbg.X = 680
        acc.X = 960
    end
    perfecteffect = Module:Find("perfecteffect")
    mhit = {}
    for i = 1, 6 do
        mhit[i] = Module:Find("hit" .. i)
        mhit[i].RotateX = angle
        mhit[i].Width = 56.9 / (ns ^ 0.5)
        mhit[i].Height = 56.9 / (ns ^ 0.5)
    end
    mkey = {}
    for i = 1, 12 do
        mkey[i] = Module:Find("key" .. i)
        mkey[i].Height = 6.48 / ns
        mkey[i].Y = -0.9 / ns
    end
    trackbottom = Module:Find("trackbottom")
    trackbottom.Height = 21.6 / ns
    trackbottom.Y = -7.2 / ns
    mpress = {}
    for i = 1, 4 do
        mpress[i] = Module:Find("press" .. i)
        mpress[i].Y = 3.51 / ns
        mpress[i].Height = 90 / ns
    end
    trackline = {}
    for i = 1, 3 do
        trackline[i] = Module:Find("trackline" .. i)
        trackline[i].Y = 2.7 / ns
        trackline[i].Height = 360 / ns
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
        for k = 1, 2 do
            tracklight[k]:DoAlpha({
                start = bpm[i].time,
                finish = bpm[i].time + 60000 / bpm[i].bpm,
                from = 100,
                to = 0,
                repeats = (bpm[i + 1].time - bpm[i].time) /
                    60000 * bpm[i].bpm // 1 + 1
            })
        end
    end
    mindicator = Module:Find("indicator")
    offblue = Module:Find("offblue")
    offgreen = Module:Find("offgreen")
    offyellow = Module:Find("offyellow")
    offp = Module:Find("offp")
    offg = Module:Find("offg")
    offm = Module:Find("offm")
    offbar = Module:Find("offbar")
    mod = Module:Find("mod")
    modtext = mod.Text
    modstr = {}
    judgetype = { "HARD", "NORMAL+", "NORMAL", "EASY+", "EASY" }
    judgetypenum = 0
    projudge = 0
    for v in string.gmatch(modtext, "[%a+]+") do
        table.insert(modstr, v)
    end
    for i = 1, #modstr do
        for k = 1, 5 do
            if (modstr[i] == judgetype[k]) then
                judgetypenum = k
                if (k <= 3) then
                    bestvalue = 20 + 8 * k
                    coolvalue = 60 + 8 * k
                    goodvalue = 105 + 8 * k
                else
                    bestvalue = 44 + 10 * (k - 3)
                    coolvalue = 84 + 10 * (k - 3)
                    goodvalue = 129 + 10 * (k - 3)
                end
            end
        end
        if (modstr[i] == "Dash") then
            rushvalue = 1.2
        elseif (modstr[i] == "Rush") then
            rushvalue = 1.5
        elseif (modstr[i] == "Slow") then
            rushvalue = 0.8
        else
            rushvalue = 1
        end
    end
    offblue.Width = 3 * bestvalue / rushvalue
    offgreen.Width = 3 * coolvalue / rushvalue
    offyellow.Width = 3 * goodvalue / rushvalue
    offbar.Width = 3 * goodvalue / rushvalue + 40
    soffani = { p1 = 0.6, p2 = 0, p3 = 0.4, p4 = 0 }
    inr = { 3, 3, 3, 3 }
end

function OnRetry()
    inr = { 3, 3, 3, 3 }
    accvalue = 0
    luaaccvalue = 0
    acc.Text = "0.00"
    mindicator.X = 0
end

function Update()
    luaaccvalue = tonumber(tonumber(string.match(luaacc.Text, "[%d.]+")))
    if (accvalue ~= luaaccvalue) then
        accvalue = luaaccvalue
        acc.Text = string.format("%.2f", accvalue)
    end
end

function OnInput()
    inputevent = Game:InputEvent()
    inputx = inputevent:HitX()
    inputtype = inputevent:Type()
    for i = 1, 4 do
        if (inputx == i) then
            inr[i] = inputtype
        end
    end
    for i = 1, 4 do
        if (inputx == i) then
            if (inr[i] == 3) then
                time = Game:Time()
                mkey[i + 8]:DoAlpha({ start = time, finish = time + 450, from = 100, to = 0 })
            end
        end
    end
end

function OnHit()
    time = Game:Time()
    hitevent = Game:HitEvent()
    judge = hitevent:JudgeResult()
    if (judge ~= 4) then
        mcombo:DoMoveY({ start = time, finish = time + 100 * rushvalue, from = 120, to = 150, ease = 2 })
    end
    if (judge == 1 or judge == 2 or judge == 3 or judge == 4) then
        if (judge == 1) then
            perfecteffect:DoResize({
                start = time,
                finish = time + 100 * rushvalue,
                from = 588 * judgesize,
                to = 840 *
                    judgesize
            }, { start = time, finish = time + 100 * rushvalue, from = 196.7 * judgesize, to = 281 * judgesize })
            perfecteffect:DoAlpha({ start = time, finish = time + 400 * rushvalue, from = 100, to = 0, custom = { p1 = 0.43, p2 = 0, p3 = 0.17, p4 = -0.11 } })
        end
        mjudge:DoResize(
            { start = time, finish = time + 100 * rushvalue, from = 254.8 * judgesize, to = 364 * judgesize },
            { start = time, finish = time + 100, from = 44.8 * judgesize, to = 64 * judgesize })
        mjudge:DoAlpha({ start = time, finish = time + 600 * rushvalue, from = 100, to = 0, custom = { p1 = 0.86, p2 = 0, p3 = 0.59, p4 = -0.11 } })
    end
    Indicator()
    if (judge == 1) then
        soffp = Module:Shadow(offp, 3000)
        soffp.X = hitevent:Offset() * -1.5 / rushvalue
        soffp:DoAlpha({
            start = time,
            finish = time + 3000 * rushvalue,
            from = 100 - math.abs(hitevent:Offset()) / 2,
            to = 0,
            custom =
                soffani
        })
    elseif (judge == 2) then
        soffg = Module:Shadow(offg, 3000)
        cooloffset = hitevent:Offset()
        soffg.X = cooloffset * -1.5 / rushvalue
        soffg:DoAlpha({
            start = time,
            finish = time + 1000 * rushvalue,
            from = 100 - math.abs(cooloffset) / 2,
            to = 0,
            custom =
                soffani
        })
        if (projudge ~= 1) then
            for i = 1, 5 do
                if (judgetypenum == i) then
                    if (i <= 3) then
                        coolpro = 20 + 8 * i
                    else
                        coolpro = 44 + 10 * (i - 3)
                    end
                    if (math.abs(cooloffset) < coolpro) then
                        projudge = 1
                        bestvalue = bestvalue - 9
                        coolvalue = coolvalue - 9
                        goodvalue = goodvalue - 20
                        offblue.Width = 3 * bestvalue / rushvalue
                        offgreen.Width = 3 * coolvalue / rushvalue
                        offyellow.Width = 3 * goodvalue / rushvalue
                    end
                end
            end
        end
    elseif (judge == 3) then
        soffm = Module:Shadow(offm, 3000)
        goodoffset = hitevent:Offset()
        soffm.X = goodoffset * -1.5 / rushvalue
        soffm:DoAlpha({
            start = time,
            finish = time + 1000 * rushvalue,
            from = 100 - math.abs(goodoffset) / 2,
            to = 0,
            custom =
                soffani
        })
        if (projudge ~= 1) then
            for i = 1, 5 do
                if (judgetypenum == i) then
                    if (i <= 3) then
                        goodpro = 60 + 8 * i
                    else
                        goodpro = 84 + 10 * (i - 3)
                    end
                    if (math.abs(goodoffset) < goodpro) then
                        projudge = 1
                        bestvalue = bestvalue - 9
                        coolvalue = coolvalue - 9
                        goodvalue = goodvalue - 20
                        offblue.Width = 3 * bestvalue / rushvalue
                        offgreen.Width = 3 * coolvalue / rushvalue
                        offyellow.Width = 3 * goodvalue / rushvalue
                    end
                end
            end
        end
    end
end

function Indicator()
    if (judge == 1 or judge == 2 or judge == 3) then
        indicvalue = hitevent:Offset() * -1.5 / rushvalue
        dicx = mindicator.X
        mindicator:DoMoveX({ start = time, finish = time + 500, from = dicx, to = indicvalue, ease = 2 })
    end
end
