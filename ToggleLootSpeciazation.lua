--获取boss信息
--local name, description, bossID, rootSectionID, link = EJ_GetEncounterInfoByIndex(bossIndex);


--修改配置的规则：需要切换的，对应的boss后写一下需要切的专精，如果该boss专精无所谓，就空着也行
local lootspecs = {
  --围攻伯拉勒斯
  ["拜恩比吉中士"]="惩戒",
  ["恐怖船长洛克伍德"]="防护",
  ["哈达尔·黑渊"]="惩戒",
  ["维克戈斯"]="",
  --地渊孢林
  ["长者莉娅克萨"]="神圣",
  ["被感染的岩喉"]="",
  ["孢子召唤师赞查"]="防护",--惩戒双手斧
  ["不羁畸变怪"]="惩戒",
  --塞塔里斯神庙
  ["阿德里斯和阿斯匹克斯"]="",
  ["米利克萨"]="惩戒",
  ["加瓦兹特"]="神圣",
  ["塞塔里斯的化身"]="神圣",--神圣饰品、防骑单手
  --托尔达戈
  ["泥沙女王"]="",
  ["杰斯·豪里斯"]="防护",
  ["骑士队长瓦莱莉"]="神圣",
  ["科古斯狱长"]="防护",
  --暴富矿区！！
  ["投币式群体打击者"]="神圣",--神圣副手，惩戒双手剑
  ["艾泽洛克"]="",
  ["瑞克莎·流火"]="",
  ["商业大亨拉兹敦克"]="防护",
  --维克雷斯庄园
  ["毒心三姝"]="",
  ["魂缚巨像"]="神圣",
  ["贪食的拉尔"]="防护",
  ["维克雷斯勋爵和夫人"]="神圣",
  ["高莱克·图尔"]="",
  --自由镇
  ["天空上尉库拉格"]="防护",
  ["海盗议会"]="",
  ["藏宝竞技场"]="惩戒",
  ["哈兰·斯威提"]="",
  --诸王之眠
  ["黄金风蛇"]="",
  ["殓尸者姆沁巴"]="防护",
  ["部族议会"]="",
  ["始皇达萨"]="",
  --阿塔达萨
  ["女祭司阿伦扎"]="",
  ["沃卡尔"]="防护",
  ["莱赞"]="防护",
  ["亚兹玛"]="",
  --风暴神殿
  ["阿库希尔"]="惩戒",
  ["海贤议会"]="",
  ["斯托颂勋爵"]="",
  ["低语者沃尔兹斯"]="",
  --团本：奥迪尔
  ["塔罗克"]="惩戒",
  ["纯净圣母"]="",
  ["腐臭吞噬者"]="防护",
  ["泽克沃兹，恩佐斯的传令官"]="神圣",--神圣单手，力量饰品
  ["维克提斯"]="神圣",--神圣饰品、盾牌、力量饰品
  ["重生者祖尔"]="",
  ["拆解者米斯拉克斯"]="神圣",--神圣饰品、力量双手、防护饰品、力量单手
  ["戈霍恩"]="防护",
  --世界boss：艾泽拉斯
  ["提赞"]="神圣",
  ["基阿拉克"]="",
  ["冰雹构造体"]="神圣",
  ["雄狮之吼"]="神圣",--神圣饰品、力量饰品
  ["蔚索斯，飞翼台风"]="神圣",--神圣饰品、力量饰品
  ["战争使者耶纳基兹"]="惩戒",
  ["食沙者克劳洛克"]="惩戒"
}
--构造专精表
local spectable = {}

local enteringWorldFrame = CreateFrame("Frame")
enteringWorldFrame:SetScript("OnEvent", function()
  for i=1,4 do
    local specId, specName = GetSpecializationInfo(i)
    if specName then
      spectable[specName]=specId
    end
  end
  print("_ToggleLootSpeciazation加载完成，请在ToggleLootSpeciazation中设置每个boss的拾取专精。")
end)
enteringWorldFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

--onEnterCombat
function onEnterCombat(encounterName)
  --目标拾取专精
  local targetSpecName = lootspecs[encounterName]
  
  if targetSpecName==nil then
    print("不存在");
    print("不存在");
    print("不存在");
    return;
  end
  if targetSpecName=="" then
    print("不需要切换拾取专精");
    print("不需要切换拾取专精");
    print("不需要切换拾取专精");
    return;
  end--为空表示任何专精都ok
  local targetSpecId = spectable[targetSpecName]
  --print(targetSpecName,targetSpecId)

  --当前拾取专精id，例如神圣65、防护66、惩戒70
  local nowSpecId = GetLootSpecialization()


  --如果专精相同则不做处理，不相同，则切换到目标专精
  if targetSpecId~=nowSpecId then
    print("切换拾取专精为：",targetSpecName)
    print("切换拾取专精为：",targetSpecName)
    print("切换拾取专精为：",targetSpecName)
    SetLootSpecialization(targetSpecId)
    --PrintLootSpecialization()
  else
    print("不需要切换拾取专精")
    print("不需要切换拾取专精")
    print("不需要切换拾取专精")
  end
end

local encouterFrame = CreateFrame("Frame");
encouterFrame:RegisterEvent("ENCOUNTER_START");
encouterFrame:SetScript("OnEvent", function(self, event,...)
  --print(event,...)
  --ENCOUNTER_START 2111 长者莉娅克萨 2 5
  
  local encounterID, encounterName, difficulty, size = ...
  onEnterCombat(encounterName)
end)

