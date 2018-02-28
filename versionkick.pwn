#define FILTERSCRIPT //Version kick TUT/FS by RogueDrifter 2017-12-9
 
#include <a_samp>//samp's team.
#include <zcmd> // the command processor by zeex
 
new bool:versioncheck;// used to make the version controllable, put at the top of ur script.
 
//=Put the following underneath ur OnPlayerConnect=//
public OnPlayerConnect(playerid)
{
    new playername[26], versionstring[10], messagestring[80];
    GetPlayerName(playerid, playername, sizeof(playername)), GetPlayerVersion(playerid, versionstring, sizeof(versionstring));  //catching the player's version & name in a string
   
    if(!strcmp(versionstring, "0.3.7-R2"))
    {           //checking if that string has the wanted version.
    //that's a normal player with the wanted version do what you want here
        }
 
    else
    {                           // if its a player on a false version
 
        if(IsPlayerNPC(playerid)) return 0;     //excluded npcs for whatever conflicts that may happen for god knows what
 
        if(!versioncheck)
        {       //if the version kick is turned on
 
            format(messagestring, sizeof(messagestring), " Server Has Kicked %s, Reason : OLD CLIENT VERSION %s ", playername,versionstring), SendClientMessageToAll(-1,messagestring);
            SendClientMessageToAll(-1, messagestring);
            SetTimerEx("DelayedKickAndMessages",500,false,"d",playerid); //delaying both the messages and the kick.
 
            }
 
        else
        {       // if the version kick is turned off
 
            format(messagestring, sizeof(messagestring), ".: Server Says: %s, OLD CLIENT VERSION %s, PLEASE UPDATE! :.", playername,versionstring);//warning the player to update
            SendClientMessageToAll(-1, messagestring);
            SetTimerEx("DelayedKickAndMessages",500,false,"d",playerid);//still delaying the message to make sure its delivered right.
 
            }
        }
 
    return 1;
}
 
//==Put the following at the bottom of your script ==//
forward DelayedKickAndMessages(playerid);
public DelayedKickAndMessages(playerid)     //the messages to download the latest version.
{
 
    SendClientMessage(playerid,-1,".: OUTDATED VERSION, UPDATE FROM: sa-mp.com/download.php :."),
    SendClientMessage(playerid,-1,".: OR COPY DIRECT LINK FROM YOUR CHATLOG http://forum.sa-mp.com/files/testing/sa-mp-0.3.7-R2-install.exe :.");//direct link & samp's link
   
    if(!versioncheck) SetPlayerWeather(playerid, 999),
    SetPlayerVirtualWorld(playerid, 999),
    SetPlayerInterior(playerid,999), Kick(playerid);            //you're free to replace the below lines to your desired samp version
   
    return 1;
}
 
//== Now to the version tog cmd, i used ZCMD but that's up to you, you can change that to whatever you want. ==//
CMD:togversion(playerid,params[])
{
    if (!IsPlayerAdmin(playerid)) return SendClientMessage(playerid,-1,"UNAUTHORIZED CMD!");//change this to your admin system
 
    if(versioncheck)    versioncheck = false, SendClientMessage(playerid,-1,".: VERSION ON :.");//if the version is OFF
    else                versioncheck = true, SendClientMessage(playerid,-1,".: VERSION OFF :.");//if the version is ON

    return 1;
}
