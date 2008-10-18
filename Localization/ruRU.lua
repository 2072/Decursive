--[[
    Decursive (v 2.0) add-on for World of Warcraft UI
    Copyright (C) 2006-2007 John Wellesz (Archarodim) ( http://www.2072productions.com/?to=decursive.php )
    This is the continued work of the original Decursive (v1.9.4) by Quu
    Decursive 1.9.4 is in public domain ( www.quutar.com )

    License:
    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation; either version 2
    of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
--]]
-------------------------------------------------------------------------------


if not DcrLoadedFiles or not DcrLoadedFiles["enUS.lua"] then
    if not DcrCorrupted then message("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DcrCorrupted = true;
    message("Decursive installation is corrupted!");
    return;
end
-------------------------------------------------------------------------------
-- Russian localization by StingerSoft (Eritnull aka Шептун)
-------------------------------------------------------------------------------
--Dcr:SetDateAndRevision("$Date: 2008-09-17 18:43:50 +0200 (mer., 17 sept. 2008) $", "$Revision: 81808 $");

local L = Dcr.L;
local LOC = Dcr.LOC;

L:RegisterTranslations("ruRU", function() return {

[LOC.DISEASE] = 'Болезни',
[LOC.MAGIC]   = 'Магия',
[LOC.POISON] = 'Яды',
[LOC.CURSE]   = 'Проклятие',
[LOC.MAGICCHARMED] = 'Магическое очарования',
[LOC.CHARMED] = 'Очарования',


[LOC.CLASS_DRUID] = 'Друид',
[LOC.CLASS_HUNTER] = 'Охотник',
[LOC.CLASS_MAGE] = 'Маг',
[LOC.CLASS_PALADIN] = 'Паладин',
[LOC.CLASS_PRIEST] = 'Жрец',
[LOC.CLASS_ROGUE] = 'Разбойник',
[LOC.CLASS_SHAMAN] = 'Шаман',
[LOC.CLASS_WARLOCK] = 'Чернокнижник',
[LOC.CLASS_WARRIOR] = 'Воин',
[LOC.CLASS_DEATHKNIGHT] = 'Deathknight';

[LOC.STR_OTHER]     = 'Другое',
[LOC.STR_OPTIONS]     = "Настройки Decursive",
[LOC.STR_CLOSE]     = 'Закрыть',
[LOC.STR_DCR_PRIO]   = 'Приоритеты Decursive',
[LOC.STR_DCR_SKIP]    = 'Пропуски Decursive',
[LOC.STR_QUICK_POP]   = 'Быстрое заполнение',
[LOC.STR_POP]	    = 'Список заполнений',
[LOC.STR_GROUP]	    = 'Группа ',




[LOC.PRIORITY_SHOW]   = 'ПР',
[LOC.POPULATE]     = 'зп',
[LOC.SKIP_SHOW]     = 'П',
[LOC.CLEAR_PRIO]     = 'О',
[LOC.CLEAR_SKIP]     = 'О',





[LOC.PET_FEL_CAST]  = "Пожирание магии",
[LOC.PET_DOOM_CAST] = "Рассеивание заклинаний",

[BINDING_NAME_DCRSHOW]    = "Показать или скрыть главную панель Decursivа\n(активный-список | указатель)",

[BINDING_NAME_DCRMUFSHOWHIDE] = "Показать или скрыть микро-фреймы игроков",

[BINDING_NAME_DCRPRADD]     = "Добавить цель в список приоритета",
[BINDING_NAME_DCRPRCLEAR]   = "Очистить список приоритета",
[BINDING_NAME_DCRPRLIST]    = "Распечатка списка приоритета",
[BINDING_NAME_DCRPRSHOW]    = "Показать или скрыть список приоритета",

[BINDING_NAME_DCRSKADD]   = "Добавить Цель в список пропусков",
[BINDING_NAME_DCRSKCLEAR] = "Очистить список пропусков",
[BINDING_NAME_DCRSKLIST]  = "Распечатка списка пропусков",
[BINDING_NAME_DCRSKSHOW]  = "Показать или скрыть список пропусков",
[BINDING_NAME_DCRSHOWOPTION] = "Отображать опции панели",


[LOC.PRIORITY_LIST]  = "Список приоритетов",
[LOC.SKIP_LIST_STR]  = "Список пропусков",
[LOC.OPTION_MENU]  = "Меню настроек Decursivа",
[LOC.POPULATE_LIST]  = "Быстро заполнить список Decursivа",
[LOC.LIST_ENTRY_ACTIONS]    = "|cFF33AA33[CTRL]|r-Клик: Удалить данного игрока\n|cFF33AA33ЛЕВЫЙ|r-Клик: Повысить данного игрока\n|cFF33AA33ПРАВЫЙ|r-Клик:Понизить данного игрока\n|cFF33AA33[SHIFT]ЛЕВЫЙ|r-Клик: Поместить данного игрока вверх\n|cFF33AA33[SHIFT]ПРАВЫЙ|r-Клик: Поместить данного игрока вниз",
[LOC.HIDE_MAIN]      = "Скрыть окно Decursivа",
[LOC.SHOW_MSG]    = "Для показа фреймов Decursivа, введите /dcrshow",
[LOC.IS_HERE_MSG]    = "Decursive инициализирован, не забудьте проверить настройки",

[LOC.PRINT_CHATFRAME] = "Выводить сообщений в стандартный чат",
[LOC.PRINT_CUSTOM]    = "Выводить сообщений в окно",
[LOC.PRINT_ERRORS]    = "Выводить сообщения о ошибках",

[LOC.SHOW_TOOLTIP]    = "Показ тултипа по зараженным игрокам",
[LOC.REVERSE_LIVELIST]= "Перевернуть отображение активного-списка",
[LOC.HIDE_LIVELIST]   = "Скрыть активный-список",
[LOC.TIE_LIVELIST]    = "Привязка обзора активного-списка к окну DCR",
[LOC.OPT_CREATE_VIRTUAL_DEBUFF] = "Создать виртуальный тест заражения",
[LOC.OPT_CREATE_VIRTUAL_DEBUFF_DESC] = "Позволяет вам увидеть как будет всё это выглядеть когда будет обнаружено заражение",

[LOC.AMOUNT_AFFLIC]   = "Значение показываемых заражений : ",
[LOC.BLACK_LENGTH]    = "Секунд в чёрном-списке : ",
[LOC.SCAN_LENGTH]     = "Секунд между активными скан.: ",
[LOC.ABOLISH_CHECK]   = "Проверка \"Снятие\" перед лечением",
[LOC.RANDOM_ORDER]    = "Лечить в случайном порядке",
[LOC.CURE_PETS]       = "Скан и лечение питомцев",
[LOC.IGNORE_STEALTH]  = "Игнорировать не видимых игроков",
[LOC.PLAY_SOUND]     = "Проиграть звук если есть кого лечить",
[LOC.ANCHOR]          = "Текстовой указатель",
[LOC.DONOT_BL_PRIO]   = "Не вносить в чёрный список имена из списка приоритетов",


    -- $s is spell name
    -- $a is affliction name/type
    -- $t is target name
[LOC.SPELL_FOUND]      = "Заклинание %s найдено!",


    -- NEW LOCALS FOR 2.0


[LOC.OPT_LIVELIST] = "Активный-Список",
[LOC.OPT_LIVELIST_DESC] = "Настройки активного списка",
[LOC.OPT_HIDELIVELIST_DESC] = "Если не скрыт, отображает информацию о зараженных игроках",
[LOC.OPT_SHOWTOOLTIP_DESC] = "Показывать тултип о заражениях в активном-списке и МФИ",
[LOC.OPT_PLAYSOUND_DESC]  = "Проиграть звук если кто-нибудь бул заражен",
[LOC.OPT_AMOUNT_AFFLIC_DESC] = "Установите максимальное число отображаемых заражений в активном-списке",
[LOC.OPT_BLACKLENTGH_DESC] =  "Установите как долго кто либо будет находиться в Черном-Списке",
[LOC.OPT_SCANLENGTH_DESC] = "Установите промежуток времени между сканированием",
[LOC.OPT_REVERSE_LIVELIST_DESC] = "Активны-Список будет заполнятся снизу вверх",
[LOC.OPT_TIE_LIVELIST_DESC] = "Отображение Активного-Списка связано с отображением панели \"Decursivа\" ",
[LOC.OPT_MESSAGES]	= "Сообщения",
[LOC.OPT_MESSAGES_DESC] = "настройки отображения сообщений",
[LOC.OPT_CHATFRAME_DESC] = "Сообщения Decursivа будут выводится в стандартное окно чата",
[LOC.OPT_PRINT_CUSTOM_DESC] = "Сообщения Decursivа будут выводится в пользовательское окно чата",
[LOC.OPT_PRINT_ERRORS_DESC] = "Выводить сообщения о ошибках",
[LOC.OPT_ANCHOR_DESC]	= "Отображать указатель пользовательского фрейма ошибок",
[LOC.OPT_MFSETTINGS] = "Настройки Микро-Фреймов Игроков",
[LOC.OPT_MFSETTINGS_DESC] = "Настройка Микро-Фреймов Игроков",
[LOC.OPT_DISPLAYOPTIONS] = "Настройки отображения",

[LOC.OPT_SHOWMFS] = "Показать Микро-Фрейм игроков",
[LOC.OPT_SHOWMFS_DESC] = "Вы должны включить если хотите лечить кликая",

[LOC.OPT_AUTOHIDEMFS]	= "Авто-Скрыть",
[LOC.OPT_AUTOHIDEMFS_DESC] = "Выберите когда скрывать МФИ",

[LOC.OPT_HIDEMFS_SOLO]		= "Один",
[LOC.OPT_HIDEMFS_SOLO_DESC]	= "Скрыть МФИ когда вы не-находитесь  в группе или в рейде",

[LOC.OPT_HIDEMFS_GROUP]		= "Один/Группа",
[LOC.OPT_HIDEMFS_GROUP_DESC]	= "Скрыть МФИ когда вы не-находитесь не в рейде",

[LOC.OPT_HIDEMFS_NEVER]		= "Никогда",
[LOC.OPT_HIDEMFS_NEVER_DESC]	= "Никогда не скрывать МФИ",

[LOC.OPT_ADDDEBUFFFHIST]		= "Добавить недавнее заражение",
[LOC.OPT_ADDDEBUFFFHIST_DESC]	= "Добавить заражение используя историю",

[LOC.OPT_GROWDIRECTION] = "Перевернуть отображение МФИ",
[LOC.OPT_GROWDIRECTION_DESC] = "МФИ бет отображаться с низу вверх",

[LOC.OPT_STICKTORIGHT] = "Выравнять МФИ вправо",
[LOC.OPT_STICKTORIGHT_DESC] = "МФИ будет расти с право на лево, рукоятка будет перемещена по мере необходимости.",
[LOC.OPT_MUFSCOLORS] = "Цвета",
[LOC.OPT_MUFSCOLORS_DESC] = "Изменить цвета Микро-Фрейма игроков.",
[LOC.MISSINGUNIT] = "Потеря игрока",
[LOC.COLORALERT] = "Установить предупреждающий цвет когда требуется '%s'.",
[LOC.COLORSTATUS] = "Установить цвет для МФИ статуса: '%s'.",
[LOC.COLORCHRONOS] = "Хронометры",
[LOC.COLORCHRONOS_DESC] = "Установить цвет хронометров",

[LOC.OPT_SHOWBORDER] = "Показать края по цвету класса",
[LOC.OPT_SHOWBORDER_DESC] = "Края МФИ будут отображаться в соответствии с предназначенным для класса цветом",
[LOC.OPT_SHOWCHRONO] = "Показать Хронометры",
[LOC.OPT_SHOWCHRONO_DESC] = "Отображение в секундах сколько времени прошло от момента заражения игрока",
[LOC.OPT_MAXMFS]  = "Всего игроков",
[LOC.OPT_MAXMFS_DESC] = "Установить максимальное число игроков которые будут отображаться на микро-фреймах",
[LOC.OPT_UNITPERLINES] = 'Игроков в линии',
[LOC.OPT_UNITPERLINES_DESC] = "Установить максимальное число игроков которые будут отображаться на одной строке микро-фреймах",
[LOC.OPT_MFSCALE] = 'Масштаб микро-фреймов игроков',
[LOC.OPT_MFSCALE_DESC] = "Установка размера микро-фреймов игроков",
[LOC.OPT_LLSCALE] = 'Масштаб Активного-Списка',
[LOC.OPT_LLSCALE_DESC] = "Установка размера главной панели Decursivа и Активного-Списка (Главная панель должна быть включена)",
[LOC.OPT_SHOWHELP] = "Показ Справки",
[LOC.OPT_SHOWHELP_DESC] = "Показывать тултип при наводке курсора мыши на микро-фреймы игроков",
[LOC.OPT_MFPERFOPT] = "Настройки быстродействия",
[LOC.OPT_MFREFRESHRATE] = 'Частота обновления',
[LOC.OPT_MFREFRESHRATE_DESC] = "Время между каждым запросом (1 or several micro-unit-frames can be refreshed at once)",
[LOC.OPT_MFREFRESHSPEED] = 'Скорость обновления',
[LOC.OPT_MFREFRESHSPEED_DESC] = "Число обновления микро-фреймов игроков в однократном прохождение",
[LOC.OPT_CURINGOPTIONS] = "Настройки лечения",
[LOC.OPT_CURINGOPTIONS_DESC] = "Установите различные аспекты процесса лечения",
[LOC.OPT_ABOLISHCHECK_DESC] = "выберите отображать ли игроков с активным заклинанием 'Снятие' и излечивать",
[LOC.OPT_DONOTBLPRIO_DESC] = "приоритетный игрок не может быть в Чёрном-списке",
[LOC.OPT_RANDOMORDER_DESC] = "Игроки будут отображаться и излечиваться наугад (не рекомендуется)",
[LOC.OPT_CUREPETS_DESC] = "Питомцы будут отображаться и излечиваться",
[LOC.OPT_IGNORESTEALTHED_DESC] = "Скрывающиеся игроки будут игнорироваться",
[LOC.OPT_CURINGORDEROPTIONS] = "Настройки Порядка Лечения",
[LOC.OPT_MAGICCHECK_DESC]	= "Если отмечено то вы будете видеть и излечивать пораженных магией игроков",
[LOC.OPT_MAGICCHARMEDCHECK_DESC] = "Если отмечено то вы будете видеть и излечивать магически-очарованных игроков",
[LOC.OPT_CHARMEDCHECK_DESC] = "Если отмечено то вы будете видеть и излечивать очарованных игроков",
[LOC.OPT_POISONCHECK_DESC] = "Если отмечено то вы будете видеть и излечивать отравленных игроков",
[LOC.OPT_DISEASECHECK_DESC] = "Если отмечено то вы будете видеть и излечивать заболевших игроков",
[LOC.OPT_CURSECHECK_DESC] = "Если отмечено то вы будете видеть и излечивать проклятых игроков",
[LOC.OPT_DEBUFFFILTER] = "Фильтрование недугов",
[LOC.OPT_DEBUFFFILTER_DESC] = "Выберите недуги по имени и классу для фильтрации в то время как вы находитесь в бою",
[LOC.OPT_MACROOPTIONS] = "Настройки Макросов",
[LOC.OPT_MACROOPTIONS_DESC] = "Установите поведение макросов созданных Decursivом",
[LOC.OPT_MACROBIND] = "Установите клавишу назначения для макроса",
[LOC.OPT_MACROBIND_DESC] = "Установка клавиши с помощью которой будет вызываться макрос 'Decursivа'.\n\nВыберите клавишу и жмите 'Enter' для сохранения нового назначения (с вашим курсором мыши над областью редактирования)",
[LOC.OPT_RESETOPTIONS] = "Сброс настроек на стандартные",
[LOC.OPT_RESETOPTIONS_DESC] =  "Сброс текущих настроек профиля на стандартные значения",
[LOC.OPT_REMOVESKDEBCONF] = "Вы уверены что вы хотите удалить\n '%s' \nиз списка пропусков?",
[LOC.OPT_RESTPROFILECONF] = "Вы уверены что вы хотите сбросить настройки профиля\n '(%s) %s' ?",
[LOC.OPT_PROFILERESET] = "Сброс профиля...",
[LOC.OPT_AFFLICTEDBYSKIPPED] = "%s пораженный %s будет пропущен",
[LOC.OPT_DEBCHECKEDBYDEF] = "\n\nНазначен на стандарт",
[LOC.OPT_ALWAYSIGNORE] = "Также игнорировать когда в не боя",
[LOC.OPT_ALWAYSIGNORE_DESC] = "Если отмечено, данный недуг будет также игнорироваться когда вы находитесь в не боя",
[LOC.OPT_REMOVETHISDEBUFF] = "Удалить данный недуг",
[LOC.OPT_REMOVETHISDEBUFF_DESC] = "Удалить '%s' из списка пропусков",
[LOC.OPT_RESETDEBUFF] = "Сброс данного недуга",
[LOC.OPT_RESETDTDCRDEFAULT] = "Сброс '%s' на стандарт Decursivа",
[LOC.OPT_USERDEBUFF] = "Данный недуг не часть стандартных недугов Decursivа",
[LOC.OPT_DEBUFFENTRY_DESC] = "Выберите какой класс будет игнорироваться в бою пораженным данным недугом",
[LOC.OPT_ADDDEBUFF] = "Добавить недуг",
[LOC.OPT_ADDDEBUFF_DESC] = "Добавить новый недуг в данный список",
[LOC.OPT_ADDDEBUFF_USAGE] = "<Название недуга>",
[LOC.OPT_READDDEFAULTSD] = "Повторно добавить стандартный недуг",
[LOC.OPT_READDDEFAULTSD_DESC1] = "Добавить утерянные стандартные недуги Decursivа в данный список\nВаши настройки не будут изменены",
[LOC.OPT_READDDEFAULTSD_DESC2] = "Все стандартные недуги Decursivа уже существуют в данном списке",

[LOC.OPT_LVONLYINRANGE] = "Только игроки в досягаемости",
[LOC.OPT_LVONLYINRANGE_DESC] = "Будут отображаться в активном-списке только те игроки которые будут находиться в радиусе рассеивания",

[LOC.OPT_MFALPHA] = "Прозрачность",
[LOC.OPT_MFALPHA_DESC] = "Установка прозрачности МФИ когда игроки не поражены",

[LOC.OPT_LLALPHA] = "Прозрачность Активного-Списка",
[LOC.OPT_LLALPHA_DESC] = "Изменение прозрачности главной панели Decursivа и Активного-Списка (Главная панель должна быть включена)",

[LOC.OPT_ADVDISP] = "Доп. Настройки отображения",
[LOC.OPT_ADVDISP_DESC] = "Позволяет установить прозрачность краёв и центра раздельно, и установки расстояние между каждым МФИ",
[LOC.OPT_TIECENTERANDBORDER] = "Объединить прозрачность центра и краёв",
[LOC.OPT_TIECENTERANDBORDER_OPT] = "Если отмечено то прозрачность краёв ровна прозрачности центра",
[LOC.OPT_BORDERTRANSP] = "Прозрачность краёв",
[LOC.OPT_BORDERTRANSP_DESC] = "Установка прозрачности краёв",
[LOC.OPT_CENTERTRANSP] = "Прозрачность центра",
[LOC.OPT_CENTERTRANSP_DESC] = "Установка прозрачности центра",
[LOC.OPT_TIEXYSPACING] = "Объединить гориз. и вертик. расстояние",
[LOC.OPT_TIEXYSPACING_DESC] = "Если отмечено то горизонтальное и вертикальное расстояние между МФИ равны",
[LOC.OPT_XSPACING] = "Расстояние по горизонтали",
[LOC.OPT_XSPACING_DESC] = "Установка расстояния по горизонтали между МФИ",
[LOC.OPT_YSPACING] = "Расстояние по вертикале",
[LOC.OPT_YSPACING_DESC] = "Установка расстояния по вертикале между МФИ",
    [LOC.OPT_SHOWMINIMAPICON] = LOC.OPT_SHOWMINIMAPICON,
    [LOC.OPT_SHOWMINIMAPICON_DESC] = LOC.OPT_SHOWMINIMAPICON_DESC,



[LOC.HLP_LL_ONCLICK_TEXT] = "Щелканье по активному-списку является бесполезным после WoW 2.0. Вы должны прочитать файл \"Readme.txt\" который находится в папке Decursivа...\n(Для перемещения этого списка переместите панель Decursivа, /dcrshow и левый-alt-клик для изменения положение)",
[LOC.HLP_LEFTCLICK] = "Левый-Клик",
[LOC.HLP_RIGHTCLICK] = "Правый-Клик",
[LOC.HLP_MIDDLECLICK] = "Центральный-Клик",

[LOC.HLP_NOTHINGTOCURE] = "В данный момент тут нечего лечить!",
[LOC.HLP_WRONGMBUTTON] = "Не верная кнопка мыши!",
[LOC.HLP_USEXBUTTONTOCURE] = "Используйте \"%s\" для излечения данного заражения!",
  
[LOC.CTRL] = "Ctrl",
[LOC.ALT] = "ALt",
[LOC.SHIFT] = "Shift",

[LOC.TARGETUNIT] = "Цель",
[LOC.FOCUSUNIT] = "Фокус",

[LOC.ABSENT] = "Отсутствует (%s)",
[LOC.TOOFAR] = "Слишком далеко",
[LOC.NORMAL] = "Нормальное",
[LOC.STEALTHED] = "Скрывается",
[LOC.BLACKLISTED] = "В Чёрном-Списке",
[LOC.UNITSTATUS] = "Состояние: ",
[LOC.AFFLICTEDBY] = "%s заражен",

[LOC.SUCCESSCAST] = "|cFF22FFFF%s %s|r |cFF00AA00успешно на|r %s",
[LOC.FAILEDCAST] = "|cFF22FFFF%s %s|r |cFFAA0000неудалось на|r %s\n|cFF00AAAA%s|r";

[LOC.HANDLEHELP] = "Тащить все микро-фреймы игроков (МФИ)",

[LOC.MACROKEYALREADYMAPPED] = "ПРЕДУПРЕЖДЕНИЕ: Назначенная клавиша для макроса Decursivа [%s] уже назначена на '%s'.\nDecursive восстановит предыдущее назначение если вы назначите другую клавишу для этого макроса.",
[LOC.MACROKEYMAPPINGSUCCESS] = "Клавиша [%s] успешно назначена для макроса Decursivа.",
[LOC.MACROKEYMAPPINGFAILED] = "Клавиша [%s] не может быть назначена для макроса Decursivа!",
[LOC.MACROKEYNOTMAPPED] = "Макросу Decursivа при наводке курсора мыши не назначена клавиша, проверьте в настройках макросов!",

[LOC.DEFAULT_MACROKEY] = "`", -- the key just beneath the escape key on a QWERTY keyboard
[LOC.OPT_NOKEYWARN] = "Известить если нет клавиши",
[LOC.OPT_NOKEYWARN_DESC] = "Показать предупреждение если нет назначенной клавиши.",
[LOC.NOSPELL] = "Нет доступных заклинаний",

[LOC.FUBARMENU] = "Меню FuBarа",
[LOC.FUBARMENU_DESC] = "Настройка иконки FuBarа",


[LOC.GLOR1] = "В память о Glorfindalе",
[LOC.GLOR2] = "Decursive посвящён памяти Бертране который оставил нас слишком рано.\nЕго будут всегда помнить.",
[LOC.GLOR3] = "В паметь о Бертрана Сана\n1969 - 2007",
[LOC.GLOR4] = "Дружба и привязанность могут пустить свои корни где-угодно, те, кто встретился с Glorfindal в Мире Вокрафта знали его как человека с великими обязательствами, и харизматического лидера \n\nHe жил, когда он был в игре, самоотверженный, щедрый, преданный своим друзьям и больше всего, страстный человек\n\nОн оставил нас в возрасте 38 лет, не только анонимные игроки в действительном мире, но и, группа истинных друзей, которые будут тосковать без его навсегда.",
[LOC.GLOR5] = "Его будут всегда помнить...",



} end);


DcrLoadedFiles["ruRU.lua"] = "@file-abbreviated-hash@";
