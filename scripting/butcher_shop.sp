#pragma semicolon 1
#pragma newdecls required

#include <butcher_core>
#include <shop>

ConVar
	cvBonusCredits;

public Plugin myinfo =
{
	name = "[Butcher Core] Shop Credits give",
	author = "Nek.'a 2x2 | ggwp.site ",
	description = "Дополнительные кредиты Мяснику",
	version = "1.0.0",
	url = "https://ggwp.site/"
};

public void OnPluginStart()
{
	cvBonusCredits = CreateConVar("sm_butcher_bonus_credits", "5", "Сколько дополнительных кредитов получит Мясник? 0 - отключить плагин");

	AutoExecConfig(true, "shop", "butcher");
}

public void BUTCHER_PlayerDeath(int client, int attacker)
{
	if(!cvBonusCredits.BoolValue)
		return;

	if(IsValidClient(attacker) && !IsFakeClient(attacker) && BUTCHER_GetStstusButcher(attacker))
	{
		Shop_GiveClientCredits(attacker, cvBonusCredits.IntValue);
	}
}

stock bool IsValidClient(int client)
{
	return 0 < client <= MaxClients && IsClientInGame(client);
}