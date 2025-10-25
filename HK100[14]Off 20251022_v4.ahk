; 20251025

#Include C:\Program Files\AutoHotkey\Lib\JSON.ahk ; Include JSON library
#NoEnv
#Persistent
SendMode Input

#SingleInstance
#Include <JSON>
FileRemoveDir, Jersey, 1

SetTitleMatchMode 2
SetFormat, float, 6.1
WinGetActiveTitle, winct
WinGet, active_winct, ID, A

;===================================================================================================================================

tailUrl := "100.100.108.127:8080"

getserver := "riding168.com"

; site_dd_mm_yy :=  "26-" A_MM "-" A_YYYY
site_dd_mm_yy := A_DD "-" A_MM "-" A_YYYY

citiKod := "3H"

overseaKod := "14H"
; overseaKod := "171H"
; overseaKod := "172H"

tkt_font := 9
odd_font := 15

combo_num =  ||1|2|3|4|5|6|7|8|9|10|11|12|13|14|

hseOddArray := {}

hse78_array := {}

hs_TktBetArray := []

hs_GetArray := []

horse_combobox_set_start_box := 980

color_ready = 0
loopcount = 0

sleepTime := 1000

; Gui Show coord ____________________________________________________________________________

gui_xpos = 0

gui_ypos = -1080

; ____________________________________________________________________________

guiId := 14
total_hs_number = %guiId%

Gui, %guiId%:Color, Black, Black
Gui, %guiId%:Margin, 0, 5

;=================================================================================================================================== Vertical Line 

line_height := 557
Gui, %guiId%:Add, Text, x25 y0 h%line_height% 0x11   ;Vertical Line > Etched Gray
Loop, %total_hs_number%
  {
   Gui, %guiId%:Add, Text, xp+135 yp+0 hp+0 0x11   ;Vertical Line > Etched Gray
  }

;=================================================================================================================================== Horizontal Line 

line_length := 1920
; Gui, %guiId%:Add, Text, x1 y130 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_94
Gui, %guiId%:Add, Text, x1 y218 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_91
Gui, %guiId%:Add, Text, x1 y327 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_86
Gui, %guiId%:Add, Text, x1 y502 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_78

;=================================================================================================================================== prcindex 1

prc_box_width   = 22
prc_box_height  = 18
prc_row_xinit   = 0
prc_row_xpos    = 0
prc_row_yinit   = 0
row_gap = 22

Gui, %guiId%:Font, s11 wbold, Arial
prcindex := 100
Gui, %guiId%:Add, Text, x%prc_row_xinit% y%prc_row_yinit% w%prc_box_width% h%prc_box_height% cwhite +Center, %prcindex%
cntprc = 1
Loop, 22
    {
    prcindex -= 1
    cntprc += 1
    Gui, %guiId%:Add, Text, xp%prc_row_xpos% yp%row_gap% w%prc_box_width% h%prc_box_height% cwhite +Center, %prcindex%
    }    
    
;=================================================================================================================================== Tkt Show Box

tkt_box_width  = 43     ; main width
tkt_box_height = 18     ; main height

tktww_xpos     = +27     ; position for first ww xpos
tktww_ypos     = -484    ; position for first ww ypos

next_xpos      = +135    ; x position for next column
next_ypos      = -484    ; x position for next column

col_gap = +0      ; x spacing between column box
row_gap = +22     ; y spacing between each row

;=================================================================================================================================== Column ww

Gui, %guiId%:Font, s%tkt_font% wbold, Arial

box_cntt = 0
loop, %total_hs_number%
   {
   box_cntt += 1
   cntedit = 100
   if (box_cntt = 1)
      {
      Gui, %guiId%:Add, Edit, xp%tktww_xpos% yp%tktww_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   else
      {
      Gui, %guiId%:Add, Edit, xp%next_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wwrow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   }

;=================================================================================================================================== Column wp

tktwp_xpos     = -1710   ; position for first wp xpos

box_cntt = 0
loop, %total_hs_number%
   {
   box_cntt += 1
   cntedit = 100
   if (box_cntt = 1)
      {
      Gui, %guiId%:Add, Edit, xp%tktwp_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   else
      {
      Gui, %guiId%:Add, Edit, xp%next_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%wprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   }

;=================================================================================================================================== Column pp

tktpp_xpos     = -1710   ; position for first pp xpos

box_cntt = 0
loop, %total_hs_number%
   {
   box_cntt += 1
   cntedit = 100
   if (box_cntt = 1)
      {
      Gui, %guiId%:Add, Edit, xp%tktpp_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   else
      {
      Gui, %guiId%:Add, Edit, xp%next_xpos% yp%next_ypos% w%tkt_box_width% h%tkt_box_height% v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
      Loop, 22
         {
         cntedit -= 1
         Gui, %guiId%:Add, Edit, xp%col_gap% yp%row_gap% wp+0 hp+0 v%box_cntt%pprow%cntedit% cgray +Left -E0x200 -VScroll, 
         }
      }
   }

;=================================================================================================================================== oddbox

box_width = 30
box_height = 25 

row_xinit = -1840
row_yinit = +33
row_xpos  = %next_xpos%
row_ypos  = +0

Gui, %guiId%:Font, s%odd_font%
cntt = 1
Gui, %guiId%:Add, Edit, xp%row_xinit% yp%row_yinit% w%box_width% h%box_height% v%cntt%oddbox cwhite +Center -E0x200 -VScroll, 
Loop, 13
   {
    cntt += 1
    Gui, %guiId%:Add, Edit, xp%row_xpos% yp%row_ypos% wp+0 hp+0 v%cntt%oddbox cwhite +Center -E0x200 -VScroll, 
   }

;=================================================================================================================================== Horse Number

horse_number_box_width = 60
horse_number_row_xinit = -1720
horse_number_row_yinit = -12
horse_number_row_xpos  = %next_xpos%
horse_number_row_ypos  = +0

Gui, %guiId%:Font, s25 wbold, Arial
cntt = 1
Gui, %guiId%:Add, ComboBox, xp%horse_number_row_xinit% yp%horse_number_row_yinit% w%horse_number_box_width% v%cntt%horse_number +Center, %combo_num%
Loop, 13
   {
    cntt += 1
    Gui, %guiId%:Add, ComboBox, xp%horse_number_row_xpos% yp%horse_number_row_ypos% w%horse_number_box_width% v%cntt%horse_number +Center, %combo_num%
   }

;=================================================================================================================================== Horizontal Line 

Gui, %guiId%:Add, Text, x1 y553 w%line_length% 0x10   ;Horizontal Line > Etched Gray below_horse num

;=================================================================================================================================== Add_Del_radio

Gui, %guiId%:Font, s8 wbold, Arial
Gui, %guiId%:Add, Radio, w33 h15 x30 yp+8 vcol_2  gcol_show2 cwhite, 2
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_3  gcol_show3 cwhite, 3
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_4  gcol_show4 cwhite, 4
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_5  gcol_show5 cwhite, 5
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_6  gcol_show6 cwhite, 6
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_7  gcol_show7 cwhite, 7
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_8  gcol_show8 cwhite, 8
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_9  gcol_show9 cwhite, 9
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_10  gcol_show10 cwhite, 10
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_11  gcol_show11 cwhite, 11
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_12  gcol_show12 cwhite, 12
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_13  gcol_show13 cwhite, 13    ;.....not shown if 2 horses
Gui, %guiId%:Add, Radio, wp+0 hp+0 xp+40 yp+0 vcol_14  gcol_show14 cwhite, 14    ;.....not shown if 2 horses

Gui, %guiId%:Add, Edit, cwhite  vsite_odd_venue +Center  w40 h20 xp+50 yp-3, Vne

Gui, %guiId%:Font, s10
; Gui, %guiId%:Add, Radio, cwhite vserver1  +Center w70 h15 xp+60 yp+3 checked, 168com
; Gui, %guiId%:Add, Radio, cwhite vserver2  +Center w65 hp+0 xp+80 yp+0, 168net
; Gui, %guiId%:Add, Radio, cwhite vserver3  +Center w68 hp+0 xp+80 yp+0, kle009
; Gui, %guiId%:Add, Radio, cwhite vserver4  +Left w65 hp+0 xp+85 yp+0, lk988
; Gui, %guiId%:Add, Radio, cwhite vserver5  +Left w75 hp+0 xp+70 yp+0, ctcom
; Gui, %guiId%:Add, Radio, cwhite vserver6  +Left w75 hp+0 xp+70 yp+0, ctnet
; Gui, %guiId%:Add, Progress, cred vprogressStatus Backgroundlime Range0-50 w40 hp+0 xp+80 yp+0, 

Gui, %guiId%:Add, Checkbox, cFuchsia voverseas_  gfuncOverseas w80 h15 xp+60 yp+3 , Overseas
Gui, %guiId%:Add, Checkbox, cwhite vshowOutsider w80 w100 hp+0 xp+90 yp+0 , Outsider  
Gui, %guiId%:Add, Checkbox, cwhite vuseTailscale w80 w100 hp+0 xp+100 yp+0 Checked, Tailscale  


Gui, %guiId%:Font, s10 wbold, Arial
Gui, %guiId%:Add, Edit, cwhite  vsite_date +Center  w40 h22 x30 yp+25, 
Gui, %guiId%:Add, Edit, cwhite  vsite_venue +Center  w40 hp+0 xp+50 yp+0, %citiKod%
Gui, %guiId%:Add, Text, cwhite   +Center  w20 hp+0 xp+50 yp+2, Rc
Gui, %guiId%:Add, ComboBox, vsite_race +Center  w40 xp+20 yp-3, %combo_num%

Gui, %guiId%:Add, Radio, cwhite vhk_get_info_radio gget_hk_data +Center w55 hp+0 xp+70 yp+2, Start
Gui, %guiId%:Add, Checkbox, cwhite w80 hp+0 xp+80 yp+0 vselectionAuto  checked, Auto 

Gui, %guiId%:Font, s10 wbold, Arial
Gui, %guiId%:Add, Button, grerun +Center w80 h20 xp+100 yp+0, NewGui
Gui, %guiId%:Add, Button, ge_xit +Center w40 h20 xp+85 yp+0, X

Gui, %guiId%:Font, s14 wbold, Arial
Gui, %guiId%:Add, Edit, cyellow  voutsidetextbar +Center  w250 h25 xp+55 yp+0, 
Gui, %guiId%:Font, s16 wbold, Arial
Gui, %guiId%:Add, Edit, cyellow  vtv_data +Left  w800 h22 xp+260 yp+0 -E0x200 -VScroll, 

;=================================================================================================================================== Horizontal Line 

line_below_navigation := 615
Gui, %guiId%:Add, Text, x1 y%line_below_navigation% w%line_length% 0x10   ;Horizontal Line > Etched Gray below_navigation

;=================================================================================================================================== gate

Gui, %guiId%:Font, s10 wbold, Arial
xx_pos  := 5
yy_pos  := line_below_navigation + 5
xx_next_pos := 82

col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h20 v%col_cntt%br cE9E6E5 +Center -E0x200 -VScroll, Gate_%col_cntt%
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== picture

xx_pos  = 20
yy_pos  := yy_pos + 25
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Picture, x%xx_pos% y%yy_pos% w50 h50 v%col_cntt%pic, 
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== caller

Gui, %guiId%:Font, s10 wbold, Arial
xx_pos  := 5
yy_pos  := yy_pos + 55
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h18 v%col_cntt%caller cwhite +Center -E0x200 -VScroll,
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== jerseyNum

Gui, %guiId%:Font, s16 wbold, Arial
xx_pos  := 5
yy_pos  := yy_pos + 20
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h20 v%col_cntt%jerseyNum cAqua +Center -E0x200 -VScroll,
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== ttl_tkt

Gui, %guiId%:Font, s10 wbold, Arial
xx_pos  := 5
yy_pos  := yy_pos + 22
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h17 v%col_cntt%ttl_tkt cA9F2A9 +Center -E0x200 -VScroll,
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== rider

Gui, %guiId%:Font, s10
xx_pos  := 5
yy_pos  := yy_pos + 15
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 h15 v%col_cntt%rider cwhite +Center -E0x200 -VScroll, 
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== horseSpeed

Gui, %guiId%:Font, s10
xx_pos  := 5
yy_pos  := yy_pos + 17
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w80 v%col_cntt%speedbox cwhite +Center -E0x200 -VScroll, 
    xx_pos += %xx_next_pos%
    col_cntt += 1
    }

;=================================================================================================================================== green box

Gui, %guiId%:Font, s9
xx_pos  = 127
yy_pos  := yy_pos - 255
col_cntt = 1
loop, %total_hs_number%
    {
    Gui, %guiId%:Add, Edit, x%xx_pos% y%yy_pos% w30 h20 v%col_cntt%greenbox clime +Center -E0x200 -VScroll, 
    xx_pos += %next_xpos%
    col_cntt += 1
    }

;=================================================================================================================================== Gui display location

gui_height := 800
   
Gui, %guiId%: -Caption
Gui, %guiId%: Show, x%gui_xpos% y%gui_ypos% w1920 h%gui_height%, BlackBoard_%total_hs_number%    ;show 12

return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

col_show2:
WinSet, Region, 0-0 W297 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show3:
WinSet, Region, 0-0 W432 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show4:
WinSet, Region, 0-0 W567 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show5:
WinSet, Region, 0-0 W702 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show6:
WinSet, Region, 0-0 W837 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show7:
WinSet, Region, 0-0 W972 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show8:
WinSet, Region, 0-0 W1107 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show9:
WinSet, Region, 0-0 W1242 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show10:
WinSet, Region, 0-0 W1377 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show11:
WinSet, Region, 0-0 W1512 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show12:
WinSet, Region, 0-0 W1647 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show13:
WinSet, Region, 0-0 W1782 h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

col_show14:
WinSet, Region, 0-0 W%line_length% h%gui_height%, BlackBoard_%total_hs_number%
WinSet, Style,  -0xC40000 , BlackBoard_%total_hs_number%
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

;  xxx   xxx  xxx   xxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx  xxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx xxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxx  xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxx  xxxxxx      xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx xxx     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx  xxx    xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxx   xxx  xxx   xxx   xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

get_hk_data:

Gui, %guiId%:Submit, nohide

;=================================================================================================================================== get source code from SCMP.COM

url_get := "https://www.scmp.com/sport/racing/racecard/@"
StringReplace, url_get, url_get, @ , %site_race%

InOutData :=
WinHttpRequest(url_get, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")
url_venue := 
url_venue := InOutData
; msgbox,,url_get, % url_venue

if (url_venue = "")
    {
    url_venue := URLDownloadToVar(url_get)
   ;  MsgBox % url_venue
    }

;=================================================================================================================================== get date

RegExMatch(url_venue, "s)<div id=""race-table-header"" class=page-racecard>`n\s+<h1>(?P<ddd>\d+) (?P<mmm>.*) (?P<yyy>\d+) - (?P<vne>Happy Valley|Sha Tin)</h1>", field1_)
_yyy :=
_yyy := field1_yyy

month_ := {"January":"01","February":"02","March":"03","April":"04","May":"05","June":"06","July":"07","August":"08","September":"09","October":"10","November":"11","December":"12"}
_mmm := 
_mmm := month_[field1_mmm]

_ddd :=
if(field1_ddd <= 9)
   {
   _ddd .= 0 . field1_ddd
   GuiControl, %guiId%:, site_date, %_ddd%
   }
else
   {
   _ddd := field1_ddd
   GuiControl, %guiId%:, site_date, %_ddd%
   }

site_dd_mm_yy = %_ddd%-%_mmm%-%_yyy%
odd_yy_mmm_dd = %_yyy%-%_mmm%-%_ddd% 
; msgbox % _ddd " - " _mmm " - " _yyy "`n" site_dd_mm_yy

;=================================================================================================================================== get venue

If(field1_vne = "Happy Valley")
   {
   vneCode = HV
   ; msgbox HV
   GuiControl, %guiId%:, site_odd_venue, %vneCode%
   GuiControl, %guiId%:, tvpos1, %hv_tv%
   }
Else
   {
   vneCode = ST
   ; msgbox ST
   GuiControl, %guiId%:, site_odd_venue, %vneCode%
   GuiControl, %guiId%:, tvpos1, %st_tv%
   }

;=================================================================================================================================== get venue course

RegExMatch(url_venue, "s)<h1>Race.*?</p>", data1)
RegExMatch(data1, "s)<p>""(?P<course>.*)"" Course, (?P<dist>\d+)", field2_)
IfInString, field2_, "All Weather Track"
   {
   field2_course := "AWT"
   }

courseDist .= vneCode "," field2_course "," field2_dist
IfInString, courseDist, +
StringReplace, courseDist, courseDist, +, \+

courseDataURL := "https://script.google.com/macros/s/AKfycbzFrTLeUdGgf6yB80c4r2ernzdNqBCxXFnn-95Q-8T33cu3a6g9W68kRu_3QhjsPtwbpA/exec"
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", courseDataURL, true)
whr.Send()
whr.WaitForResponse()
courseData := ""
courseData := whr.ResponseText

StringReplace, courseData, courseData, ",, all

RegExMatch(courseData, "s)(" courseDist ")(.*?])", rc_data)
StringReplace, rc_data, rc_data, ], 


GuiControl, %guiId%:, tv_data, %rc_data%
if (field2_dist >= 1600 && field2_dist < 1800) 
   {
   Gui, %guiId%:Font, s16 cff9900
   GuiControl, %guiId%:Font, tv_data
   }
else if (field2_dist >= 1800) 
   {
   Gui, %guiId%:Font, s16 cred
   GuiControl, %guiId%:Font, tv_data
   }

;=================================================================================================================================== get errhorse

; errorHorseListURL := "https://docs.google.com/spreadsheets/d/e/2PACX-1vQUzYHuycnwsFix3k4v76cPIiNJQhlBvTVqj7LoHhsiq44KsEl4X4AQCEBxOGn2ibMp31D0fVLyjSDH/pub?gid=0&single=true&output=csv"
; ; errorHorseListURL := "https://docs.google.com/spreadsheets/d/1gCXp8InLhB85mRZZiaLvKLytYAgW8ZmAgHMKzoYBOYU/export?format=csv"
; whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
; whr.Open("GET", errorHorseListURL, true)
; whr.Send()
; whr.WaitForResponse()
; errorHorseList := ""
; errorHorseList := whr.ResponseText

;=================================================================================================================================== get outsider

outsider_url := "https://script.google.com/macros/s/AKfycbxMqbXQ4rvewvjOB-ONymDfzrYGv-tBhVW5GwEy7liRSDugFrpek18AM2gH-Xa-LKxu/exec"
outsiderListURL := outsider_url

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", outsiderListURL, true)
whr.Send()
whr.WaitForResponse()
outsiderList := ""
outsiderList := whr.ResponseText
StringReplace, outsiderList, outsiderList, ",, all

RegExMatch(outsiderList, "s)r(" site_race ")(.*?])", outsiderData)
; msgbox % outsiderList "`r`r" outsiderData
StringReplace, outsiderData2, outsiderData2, `,, 
StringReplace, outsiderData2, outsiderData2, ], 
; msgbox % outsiderData2

GuiControl, %guiId%:, outsidetextbar, %outsiderData2%

;=================================================================================================================================== get horse speed

testurl01 := "https://script.google.com/macros/s/AKfycbzgDQM4WM6xJz1SYqE5TxDfwyekTVuymLPIcyeyLYU4iiJVjXsQwFBS3O4BilMqs3ELMA/exec"
testurl02 := "https://script.google.com/macros/s/AKfycbz6q_WDw6iiDJkpAuW11cvoF3Mi9FRxSm4BPlU5wm5T8FqxJ0psXPoy9i_u_65c8S8e/exec"
testurl03 := "https://script.google.com/macros/s/AKfycbzPDWKdbGpDJXeHo2frIub1gO7Zv7PzxKQYMilghNehljof3fJT-mAN2tCwndzIgOY1/exec"
testurl04 := "https://script.google.com/macros/s/AKfycbw0osWoyv0dU2R18HwInFPEjXZDBkLUwNiZKlrg58oXxv2DFAb5TsbOPQGd3-c9Nir6/exec"
testurl05 := "https://script.google.com/macros/s/AKfycbz8BC4MIx1eVI_QSXm8l2iFrv3lLiNqgviUG_wM4qaydTzueMq7vlFhNgTP3AlsxCsL/exec"
testurl06 := "https://script.google.com/macros/s/AKfycbw3rCBbar-nAMbe1JQJWkagZ6H_wHfQz9nTTWUu5xN_COiyoUIiNaIaYN6uqTbli89R/exec"
testurl07 := "https://script.google.com/macros/s/AKfycbwO8u5LjMuF71fHIJ53iOEly1wBO-EpvNXtBPpU9XgDGpEfJC5MPMvYnGzFAYlqJUHJXg/exec"
testurl08 := "https://script.google.com/macros/s/AKfycbxvzLIrGgMC0AtVOVaGY21MG3DEECbH0PdD8cfh1EMMyNzHEtP_uxUd_m-pYEaUvEDj9Q/exec"
testurl09 := "https://script.google.com/macros/s/AKfycbx2sce-54PXdAHOsb_k65N8uULuZY23xtJoIXo-Gpu8NL7d69ZBJXwF1Zc4NvS4EXA6/exec"
testurl010 := "https://script.google.com/macros/s/AKfycbyLOZeJKRxkhRtBLpvPgpvJ9V4wwznYfVoRZb6lje5x3SvcPkSxVtkqC0M1C-sGdMAgFg/exec"
testurl011 := "https://script.google.com/macros/s/AKfycbwFu2O_GOfQtj7oBjMsht3CuO1oZcOlBtsNKU7QcXxZWnUZOV-e4j9DDYRx_xJF3O4L/exec"

if (site_race = 1)
   {
   hseSpeedURL :=  testurl01
   }
else if (site_race = 2)
   {
   hseSpeedURL :=  testurl02
   }
else if (site_race = 3)
   {
   hseSpeedURL :=  testurl03
   }
else if (site_race = 4)
   {
   hseSpeedURL :=  testurl04
   }
else if (site_race = 5)
   {
   hseSpeedURL :=  testurl05
   }
else if (site_race = 6)
   {
   hseSpeedURL :=  testurl06
   }
else if (site_race = 7)
   {
   hseSpeedURL :=  testurl07
   }
else if (site_race = 8)
   {
   hseSpeedURL :=  testurl08
   }
else if (site_race = 9)
   {
   hseSpeedURL :=  testurl09
   }
else if (site_race = 10)
   {
   hseSpeedURL :=  testurl010
   }
else if (site_race = 11)
   {
   hseSpeedURL :=  testurl011
   }

whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", hseSpeedURL, true)
whr.Send()
whr.WaitForResponse()
hseSpeedList := ""
hseSpeedList := whr.ResponseText

StringReplace, hseSpeedList, hseSpeedList, ",, all
; msgbox % hseSpeedList

loop, 14
   {
   RegExMatch(hseSpeedList, "s)\[(.*?\])", paceData)   
	StringReplace, hseSpeedList, hseSpeedList, %paceData%
	StringReplace, paceData, paceData, [,, all
	StringReplace, paceData, paceData, ],, all
   StringSplit, dataArray, paceData, `,
   ; MsgBox,  % hseSpeedList "`n`n`npaceData := " paceData
   ; . "`nhs : " dataArray1
   ; . "`ncode : " dataArray2
   ; . "`npace : " dataArray3
   ; . "`ncaller : " dataArray4
   ; . "`ngate : " dataArray5

   GuiControl, %guiId%:, %dataArray5%caller, %dataArray4%
   GuiControl, %guiId%:, %dataArray5%jerseyNum, %dataArray1%
   GuiControl, %guiId%:, %dataArray5%speedbox, %dataArray3%
   
         if (dataArray3 = "L1")
            {
            Gui, %guiId%:Font, s10 c00ff00
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            }
         else if (dataArray3 = "L2")
            {
            Gui, %guiId%:Font, s10 c00ff00
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if (dataArray3 = "L3")
            {
            Gui, %guiId%:Font, s10 c00ff00
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if dataArray3 contains Normal
            {
            Gui, %guiId%:Font, s10 cffff00
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            }   
         else if (dataArray3 = "Slow")
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            }   
         else if (dataArray3 = "Slow_1") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            }   
         else if (dataArray3 = "Slow_2") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            }   
         else if (dataArray3 = "Slow_3") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if (dataArray3 = "V_Slow") 
            {
            Gui, %guiId%:Font, s10 cff0000
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if (dataArray3 = "New") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if (dataArray3 = "New_X") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if (dataArray3 = "New_1") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
         else if (dataArray3 = "New_2") 
            {
            Gui, %guiId%:Font, s10 cffffff
            GuiControl, %guiId%:Font, %dataArray5%speedbox
            } 
   }

; return

;=================================================================================================================================== get jersey

RegExMatch(url_venue, "s)<div class=""race-table"">(.*)<table class=""remarks"">", data2)
FileCreateDir, Jersey

loop, %total_hs_number%
      {
      RegExMatch(data2, "s)""horse_number"">(?P<hseNum>" A_Index ")</td>", field3_)
      StringReplace, data2, data2, % field3_, 

      RegExMatch(data2, "s)<a href=""/sport/racing/stats/horses/(?P<hsCode>.\d+)/", field4_)
      StringReplace, data2, data2, % field4_, 
      if (field3_hsenum > 0)
         {
         URLDownloadToFile, https://racing.hkjc.com/racing/content/Images/RaceColor/%field4_hsCode%.gif, %A_ScriptDir%\jersey\jersey%field4_hsCode%.gif

         RegExMatch(data2, "s)<td align=""center"">(?P<br>\d+)</td><td align=""center"" class=""overnight_win_odds"">", field5_)
         StringReplace, data2, data2, % field5_, 


         GuiControl, %guiId%:, %field5_br%pic, %A_ScriptDir%\jersey\jersey%field4_hsCode%.gif
         }

      RegExMatch(data2, "s)<a href=""/sport/racing/stats/jockey/\d+/(?P<rider>.*?)<", field5_)
      StringReplace, data2, data2, % field5_, 
      StringSplit, namefield, field5_rider, "
      GuiControl, %guiId%:, %field5_br%rider, %namefield1%
      }

;===================================================================================================================================

goto, get_citi_data
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

get_citi_data:
Gui, %guiId%:Submit, nohide

hari := _ddd
bulan := _mmm
tahun := _yyy
kod := vneCode
larian := site_race

;=================================================================================================================================== get_odd from HKJC

get_odd:

; URL for the request (replace with your actual API endpoint)
url := "https://info.cld.hkjc.com/graphql/base/"

; Create the COM Object for XMLHTTP
http := ComObjCreate("MSXML2.XMLHTTP")

; GraphQL query and variables payload
payload := "{" 
payload .= """operationName"": ""racing"","
payload .= """variables"": {"
payload .= """date"": """ tahun "-" bulan "-" hari ""","
payload .= """venueCode"": """ kod ""","
payload .= """raceNo"": " larian ","
payload .= """oddsTypes"": [""WIN"", ""PLA""]"
payload .= "},"
payload .= """query"": ""query racing($date: String, $venueCode: String, $oddsTypes: [OddsType], $raceNo: Int) {"
payload .= "  raceMeetings(date: $date, venueCode: $venueCode) {"
payload .= "    pmPools(oddsTypes: $oddsTypes, raceNo: $raceNo) {"
payload .= "      id"
payload .= "      status"
payload .= "      sellStatus"
payload .= "      oddsType"
payload .= "      lastUpdateTime"
payload .= "      guarantee"
payload .= "      minTicketCost"
payload .= "      name_en"
payload .= "      name_ch"
payload .= "      leg {"
payload .= "        number"
payload .= "        races"
payload .= "      }"
payload .= "      cWinSelections {"
payload .= "        composite"
payload .= "        name_ch"
payload .= "        name_en"
payload .= "        starters"
payload .= "      }"
payload .= "      oddsNodes {"
payload .= "        combString"
payload .= "        oddsValue"
payload .= "        hotFavourite"
payload .= "        oddsDropValue"
payload .= "        bankerOdds {"
payload .= "          combString"
payload .= "          oddsValue"
payload .= "        }"
payload .= "      }"
payload .= "    }"
payload .= "  }"
payload .= "}"""
payload .= "}"

; msgbox,,Payload, % payload,

; Open the POST request
http.Open("POST", url, false)

; Set the request headers
http.SetRequestHeader("Content-Type", "application/json")

; Send the POST request with the payload
http.Send(payload)

; Get the response text (JSON)
response := http.ResponseText

; Display the response in a message box
; msgbox % "Response from the server:`n" response

; FileAppend, %response%, %A_ScriptDir%\httpPostData_%A_MM%%A_DD%.json

; Parse JSON data
parsedJSON := JSON.Load(response)


loop, 14
   {
   ; Accessing values
   raceMeeting := parsedJson.data.raceMeetings[1]  ; Access the first race meeting
   pmPools := raceMeeting.pmPools[2]  ; Access the first pmPool of that meeting

   ; Accessing odds for specific horses
   firstHorseCombString := pmPools.oddsNodes[A_Index].combString
   firstHorseOddsValue := pmPools.oddsNodes[A_Index].oddsValue
   ; firstHorseHotFavourite := pmPools.oddsNodes[1].hotFavourite

   ; Output the results
   ; MsgBox, Horse 1 combString: %firstHorseCombString%`nOdds Value: %firstHorseOddsValue%`nHot Favourite: %firstHorseHotFavourite%
   ; MsgBox, Horse 1 combString: %firstHorseCombString%`nOdds Value: %firstHorseOddsValue%
   hseOddArray[firstHorseCombString] := firstHorseOddsValue
   }

;=================================================================================================================================== select server 

if (useTailscale = 1)
   {
   ; msgbox,,tailscale, Tailscale checked
   URLb := "http://@/bet"
   StringReplace, URLb, URLb, @, %tailUrl%
   }
else
   {
   ; msgbox,,tailscale, Tailscale Unchecked
   URLb := "https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

         StringReplace, URLb, URLb, * , %getserver%      
         StringReplace, URLb, URLb, @, %site_dd_mm_yy%
         StringReplace, URLb, URLb, # , %site_venue%
         StringReplace, URLb, URLb, $ , %site_race%

   ; MsgBox % URLb
   }

InOutData :=
WinHttpRequest(URLb, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")
bethtml := 
bethtml := InOutData  
; MsgBox % bethtml

;=================================================================================================================================== get horse count

hseCntt = 0
combox_num := horse_combobox_set_start_box

loop, %total_hs_number%
   {
   if (%A_Index%jerseyNum > 0)
      {
      Gate_get := %A_Index%br 
      StringReplace, Gate_get, Gate_get, Gate_, 
      barrier_array%A_Index% := Gate_get
      horse_array%A_Index% := %A_Index%jerseyNum   
      hseCntt++
      ; msgbox % barrier_array%A_Index% " - " horse_array%A_Index%
      }
   }

;=================================================================================================================================== show total bet tkt

loop, % hseCntt
	{
	hse_num := horse_array%A_Index%	
	barrier_num := barrier_array%A_Index%	
	; MsgBox,,Line 9xx, % "gate_num = " gate_num "`nhse_num = " hse_num 

;=================================================================================================================================== ww tkt
	
		ww_bet := 0
		Loop,
			{
			; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d+)\\t(0)\\t(\d+|\d+.\d+)\\t([!]*\d+[.]*[\d]*\/0)", s_tkt)
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([0])", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d|\d+)\\t([^1-9])", s_tkt)
			if(s_tkt != "")
				{       
				ww_bet += %s_tkt3% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			}

;=================================================================================================================================== wp tkt
	
		wp_bet := 0
		Loop,
			{
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d+)\\t(\d+)\\t(\d+|\d+.\d+)\\t(.\d+\/\d+)", s_tkt)
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([^0]\d+)", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([^0]\d+)", s_tkt)
			if(s_tkt != "")
				{
				wp_bet += %s_tkt3% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			} 

;=================================================================================================================================== pp tkt
	
		pp_bet := 0
		Loop,
			{	
		   ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(0)\\t(\d+)\\t(\d+|\d+.\d+)\\t([!]*0\/\d+)", s_tkt)
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([0])\\t([^0]\d+)", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^1-9])\\t([^0]\d+)", s_tkt)
			if(s_tkt != "")
				{         
				pp_bet += %s_tkt4% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			}
         
;===================================================================================================================================
	
	ttltkt := 0
	ttltkt := ww_bet + wp_bet + pp_bet

	if (ttltkt >= 500000)
		{
		Gui, %guiId%:Font, s10 cff0000
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else if (ttltkt < 500000  && ttltkt >= 200000 )
		{
		Gui, %guiId%:Font, s10 cFFC300
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else if (ttltkt < 200000  && ttltkt >= 100000 )
		{
		Gui, %guiId%:Font, s10 cA9F2A9
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else if (ttltkt < 100000  && ttltkt >= 1 )
		{
		Gui, %guiId%:Font, s10 csilver
		GuiControl, %guiId%:Font, %barrier_num%ttl_tkt
		GuiControl, %guiId%:, %barrier_num%ttl_tkt, %ttltkt% 
      combox_num ++
      if (selectionAuto = 1)
         ControlSetText, Edit%combox_num%, %hse_num%, BlackBoard_%total_hs_number%
		}
	else
		{
		GuiControl, %guiId%:, %barrier_num%ttl_tkt,
      hse78_array.push(hse_num)
		} 
	}

if (selectionAuto = 1)
   {
   ; msgbox  selectionAuto = 0
   Control, Uncheck ,, Button22, BlackBoard_%showHorseCount%

   ; fill remaining horse number box without any bet ticket
   ; if (showOutsider = 1)
   ;    {
   ;    ; msgbox,,outsider value, % showOutsider 
   ;    Loop % hse78_array.Length()
   ;       {
   ;       combox_num +=1
   ;       combobox_fill := hse78_array[A_Index]
   ;       ; MsgBox % "combox_num : " combox_num  "`nhse78_array[A_Index] : " hse78_array[A_Index]
   ;       ControlSetText, Edit%combox_num%, %combobox_fill%, BlackBoard_%horse_show_tkt_box%
   ;       }
   ;    }
   }

goto, loop_server_data
return

;===================================================================================================================================
;===================================================================================================================================
;===================================================================================================================================

loop_server_data:

Gui, %guiId%:Submit, nohide

;===================================================================================================================================

if (useTailscale = 1)
   {
   ; msgbox,,tailscale, Tailscale checked
   URLb := "http://@/bet"
   StringReplace, URLb, URLb, @, %tailUrl%

   
   URLe := "http://@/eat"   
   StringReplace, URLe, URLe, @, %tailUrl%
   }
else
   {
   ; msgbox,,tailscale, Tailscale Unchecked
   URLb := "https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

         StringReplace, URLb, URLb, * , %getserver%      
         StringReplace, URLb, URLb, @, %site_dd_mm_yy%
         StringReplace, URLb, URLb, # , %site_venue%
         StringReplace, URLb, URLb, $ , %site_race%

   ; MsgBox % URLb
   
   URLe :="https://datas.*/edata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"
         StringReplace, URLe, URLe, * , %getserver%
         StringReplace, URLe, URLe, @, %site_dd_mm_yy%
         StringReplace, URLe, URLe, # , %site_venue%
         StringReplace, URLe, URLe, $ , %site_race%

   ; MsgBox % URLe
   }

;===================================================================================================================================

bethtml :=
WinHttpRequest(URLb, bethtml := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")

eathtml :=
WinHttpRequest(URLe, eathtml := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")

; msgbox,,bethtml, % URLb "`n`n" bethtml,.5
; msgbox,,eathtml, % URLe "`n`n" eathtml,.5

;===================================================================================================================================

IfNotInString, eathtml, 90
    {
    loopcount ++     
    if (loopcount > 150)            ;tukar pusing
      {
      ; ElapsedTime := A_TickCount - StartTime
      ; GuiControl, %guiId%:, timer_box, %ElapsedTime%
      ; MsgBox,  %ElapsedTime% milliseconds have elapsed.
      ; Gui, %guiId%:Color, 132279, 132279
      ; MsgBox, Racing!!! `n`nReload?
      ; Reload 

      GuiControl, %guiId%:, progressStatus, 100  
      }
    else
      {
      Goto, loop_server_data
      loopcount = 0
      }
    } 

;=================================================================================================================================== show tkt range
;===================================================================================================================================
;===================================================================================================================================

Gui, %guiId%:Submit, nohide

;=================================================================================================================================== get runner

combox_num := horse_combobox_set_start_box
selected_runner :=
Loop, %total_hs_number%
   {
   combox_num ++
   hseComboboxValue := 
   ControlGetText, hseComboboxValue, Edit%combox_num%,  BlackBoard_%total_hs_number%
   ; msgbox % hseComboboxValue
	if(hseComboboxValue > 0)
      {
      selected_runner += 1
      horse_array%selected_runner% := hseComboboxValue
      GuiControl, %guiId%:, %A_Index%oddbox, % hseOddArray[ hseComboboxValue ]
      if (hseOddArray[ hseComboboxValue ] <= 5)
         {
         Gui, %guiId%:Font, s%odd_font% cred
         GuiControl, %guiId%:Font, %A_Index%oddbox
         }
      Else
         {
         Gui, %guiId%:Font, s%odd_font% cwhite
         GuiControl, %guiId%:Font, %A_Index%oddbox
         }
      }
	; if(%A_Index%horse_number > 0)
   ;     {
   ;      selected_runner += 1
   ;      horse_array%selected_runner% := %A_Index%horse_number
   ;     }
   }

; show total number of combo_box with value 
; msgbox,,selected_runner, % selected_runner, 3 

;=================================================================================================================================== show tkt

Loop, %selected_runner%
   {
   hsenum := horse_array%A_Index%
   box_row := A_Index

;=================================================================================================================================== ww tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      ww_bet := 0
      Loop,
         {
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([0])\\t(" prc_lmt ")", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {         
            ww_bet += %s_tkt3%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      ww_eat := 0
      Loop,
         {
         ; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([0])\\t(" prc_lmt ")", s_tkt)
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {         
            ww_eat += %s_tkt3%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(ww_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, %ww_bet% 
            if (ww_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%             
               }
            }
         else if(ww_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, %ww_eat%  
            if (ww_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%     
               ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               if (prc_lmt = 87)
                  {
                  Gui, %guiId%:Font, s%tkt_font% cwhite
                  GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%   
                  }                   
               }  
            }
         else
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%,
            }
         prc_lmt += 1
      } 

;=================================================================================================================================== wp tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      wp_bet := 0
      Loop,
         {
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {
            wp_bet += %s_tkt3%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      wp_eat := 0
      Loop,
         {
         ; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {
            wp_eat += %s_tkt3%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(wp_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, %wp_bet%  
            if (wp_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%
               GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%             
               }
            }
         else if(wp_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, %wp_eat%  
            if (wp_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%  
               ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               if (prc_lmt = 87)
                  {
                  Gui, %guiId%:Font, s%tkt_font% cwhite
                  GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%   
                  }                     
               }
            } 
         else
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%,
            }
         prc_lmt += 1
      }    

;=================================================================================================================================== pp tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      pp_bet := 0
      Loop,
         {
         ; RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([0])\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt4 != "")
            {         
            pp_bet += %s_tkt4%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      pp_eat := 0
      Loop,
         {
         ; RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([0])\\t([^0]\d+)\\t(" prc_lmt ")", s_tkt)
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt4 != "")
            {         
            pp_eat += %s_tkt4%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(pp_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, %pp_bet% 
            if (pp_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%             
               }
            }
         else if(pp_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, %pp_eat% 
            if (pp_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%
               ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               if (prc_lmt = 87)
                  {
                  Gui, %guiId%:Font, s%tkt_font% cwhite
                  GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%   
                  }                  
               }
            } 
         else
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%,
            }
         prc_lmt += 1
      }

;===================================================================================================================================  end

   }
sleep, %sleepTime%
Goto, get_citi_data
return

;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 

funcOverseas:

Gui, %guiId%:Submit, nohide

if (useTailscale = 1)
   {
   ; msgbox,,tailscale, Tailscale checked
   URLb := "http://@/bet"
   StringReplace, URLb, URLb, @, %tailUrl%
   }
else
   {
   ; msgbox,,tailscale, Tailscale Unchecked
   URLb := "https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

         StringReplace, URLb, URLb, * , %getserver%      
         StringReplace, URLb, URLb, @, %site_dd_mm_yy%
         StringReplace, URLb, URLb, # , %overseaKod%
         StringReplace, URLb, URLb, $ , %site_race%

   ; MsgBox % URLb
   }

InOutData :=
WinHttpRequest(URLb, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")
bethtml := 
bethtml := InOutData  
; MsgBox,,, % bethtml, .5

hseCntt = 20
combox_num := horse_combobox_set_start_box
; combobox_set := 

loop, % hseCntt
	{
	hse_num := A_Index
	barrier_num := A_Index
	; MsgBox,,Line 9xx, % "gate_num = " gate_num "`nhse_num = " hse_num 

;=================================================================================================================================== ww tkt
	
		ww_bet := 0
		Loop,
			{
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t(\d|\d+)\\t([^1-9])", s_tkt)
			if(s_tkt != "")
				{       
				ww_bet += %s_tkt3% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			}

;=================================================================================================================================== wp tkt
	
		wp_bet := 0
		Loop,
			{
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^0]\d+)\\t([^0]\d+)", s_tkt)
			if(s_tkt != "")
				{
				wp_bet += %s_tkt3% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			} 

;=================================================================================================================================== pp tkt
	
		pp_bet := 0
		Loop,
			{
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hse_num ")\\t([^1-9])\\t([^0]\d+)", s_tkt)
			if(s_tkt != "")
				{         
				pp_bet += %s_tkt4% 
				StringReplace, bethtml, bethtml, %s_tkt%
				}
			else
				{
				break   
				}           
			}
         
;===================================================================================================================================
	
	ttltkt := 0
	ttltkt := ww_bet + wp_bet + pp_bet

	if (ttltkt >= 1)
      {     
      combox_num++
      ; hs_TktBetArray.Push(combox_num)
      hs_TktBetArray[combox_num] := A_Index
      ; msgbox,,, % hse_num
      ; . "`ncombobox : " combox_num
      ; . "`narray : " hs_TktBetArray[combox_num]
      }
   }

   for k , v in hs_TktBetArray
      {
      ; msgbox, % k " : " v
      ControlSetText, Edit%k%, %v%, BlackBoard_%total_hs_number%
      }

; msgbox, % hs_TktBetArray[0][0]


;=================================================================================================================================== show tkt

funcLoopOverSeas:

combox_num := horse_combobox_set_start_box
Gui, %guiId%:Submit, nohide

if (useTailscale = 1)
   {
   ; msgbox,,tailscale, Tailscale checked
   URLb := "http://@/bet"
   StringReplace, URLb, URLb, @, %tailUrl%

   
   URLe := "http://@/eat"   
   StringReplace, URLe, URLe, @, %tailUrl%
   }
else
   {
   ; msgbox,,tailscale, Tailscale Unchecked
   URLb := "https://datas.*/betdata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"

         StringReplace, URLb, URLb, * , %getserver%      
         StringReplace, URLb, URLb, @, %site_dd_mm_yy%
         StringReplace, URLb, URLb, # , %overseaKod%
         StringReplace, URLb, URLb, $ , %site_race%

   ; MsgBox % URLb
   
   URLe :="https://datas.*/edata?race_date=@&race_type=#&rc=$&m=HK&c=2&lu=0"
         StringReplace, URLe, URLe, * , %getserver%
         StringReplace, URLe, URLe, @, %site_dd_mm_yy%
         StringReplace, URLe, URLe, # , %overseaKod%
         StringReplace, URLe, URLe, $ , %site_race%

   ; MsgBox % URLe
   }

InOutData :=
WinHttpRequest(URLb, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")
bethtml := 
bethtml := InOutData  
; MsgBox,,, % bethtml, .5

InOutData :=
WinHttpRequest(URLe, InOutData := "", InOutHeaders := Headers(), "Timeout: 1`nNO_AUTO_REDIRECT")
InOutData := RegExReplace(InOutData, "<script>.*DATA>")
eathtml := 
eathtml := InOutData  
; MsgBox,,, % eathtml, .5

loop, 14
   {
   combox_num++   
   ControlGetText, hseComboboxValue, Edit%combox_num%,  BlackBoard_%total_hs_number%
   if (hseComboboxValue > 0)
      {
      hs_GetArray.Push(hseComboboxValue)
      }
   }


Loop, % hs_GetArray.count()
   {
   hsenum := hs_GetArray[A_index]
   box_row := A_Index
   ; msgbox,,hs_GetArray.count, % hs_GetArray.count() "`n" hsenum "`n" box_row 
;=================================================================================================================================== ww tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      ww_bet := 0
      Loop,
         {
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {         
            ww_bet += %s_tkt3%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      ww_eat := 0
      Loop,
         {
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t(\d|\d+)\\t([^1-9])\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {         
            ww_eat += %s_tkt3%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(ww_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, %ww_bet% 
            if (ww_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%             
               }
            }
         else if(ww_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, %ww_eat%  
            if (ww_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%     
               ; ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               ; if (prc_lmt = 87)
               ;    {
               ;    Gui, %guiId%:Font, s%tkt_font% cwhite
               ;    GuiControl, %guiId%:Font, %box_row%wwrow%prc_lmt%   
               ;    }                   
               }  
            }
         else
            {
            GuiControl, %guiId%:, %box_row%wwrow%prc_lmt%,
            }
         prc_lmt += 1
      } 

;=================================================================================================================================== wp tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      wp_bet := 0
      Loop,
         {
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {
            wp_bet += %s_tkt3%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      wp_eat := 0
      Loop,
         {
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^0]\d+)\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt3 != "")
            {
            wp_eat += %s_tkt3%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(wp_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, %wp_bet%  
            if (wp_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%
               GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%             
               }
            }
         else if(wp_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, %wp_eat%  
            if (wp_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%wprow%prc_lmt%, 999999 
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%  
               ; ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               ; if (prc_lmt = 87)
               ;    {
               ;    Gui, %guiId%:Font, s%tkt_font% cwhite
               ;    GuiControl, %guiId%:Font, %box_row%wprow%prc_lmt%   
               ;    }                     
               }
            } 
         else
            {
            GuiControl, %guiId%:, %box_row%wprow%prc_lmt%,
            }
         prc_lmt += 1
      }    

;=================================================================================================================================== pp tkt
   
   prc_lmt := 78      
   Loop, 23
      {
      pp_bet := 0
      Loop,
         {
         RegExMatch(bethtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt4 != "")
            {         
            pp_bet += %s_tkt4%    
            StringReplace, bethtml, bethtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }
         
      pp_eat := 0
      Loop,
         {
         RegExMatch(eathtml, "s)\\n(\d+)\\t(" hsenum ")\\t([^1-9])\\t([^0]\d+)\\t(" prc_lmt ")\\t", s_tkt)
         if(s_tkt4 != "")
            {         
            pp_eat += %s_tkt4%    
            StringReplace, eathtml, eathtml, %s_tkt%
            }
         else
            {
            break   
            }           
         }  
         
         if(pp_bet > 0)
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, %pp_bet% 
            if (pp_bet >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cred
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cA9F2A9
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%             
               }
            }
         else if(pp_eat > 0)
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, %pp_eat% 
            if (pp_eat >= 999999) 
               {
               Gui, %guiId%:Font, s%tkt_font% cffff00
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt% 
               GuiControl, %guiId%:, %box_row%pprow%prc_lmt%, 999999
               }
            else
               {
               Gui, %guiId%:Font, s%tkt_font% cgray
               GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%
               ; ; if (prc_lmt = 89||prc_lmt = 88||prc_lmt = 87||prc_lmt = 86||prc_lmt = 85)
               ; if (prc_lmt = 87)
               ;    {
               ;    Gui, %guiId%:Font, s%tkt_font% cwhite
               ;    GuiControl, %guiId%:Font, %box_row%pprow%prc_lmt%   
               ;    }                  
               }
            } 
         else
            {
            GuiControl, %guiId%:, %box_row%pprow%prc_lmt%,
            }
         prc_lmt += 1
      }

;===================================================================================================================================  end

   }

sleep, %sleepTime%
Goto, funcLoopOverSeas
return

;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 
;  xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx   xxxxxxxxxx 

`::     ;tilde key - start hypercam recording
send, {NumpadMult}
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Pause::
Pause
return

rerun:
Reload
return

99GuiClose:
e_xit:
FileRemoveDir, Jersey, 1
ExitApp
return

PrintScreen::
Gui, %guiId%: Show, x0 y0 w1920, BlackBoard_%total_hs_number%
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

RButton::Send,{Click,Right}
RButton & LButton::
;!LButton::

CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; Only if the window isn't maximized 
    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return

EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
    SetTimer, EWD_WatchMouse, off
    return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is Destroyled.
{
    SetTimer, EWD_WatchMouse, off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
    return
}
; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

URLDownloadToVar(url){
	obj:=ComObjCreate("WinHttp.WinHttpRequest.5.1"),obj.Open("GET",url),obj.Send()
	return obj.status=200?obj.ResponseText:""
}

;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
;  xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
