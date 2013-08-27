scope ShBot initializer init
    function Trig_Lower_Line_Sound_Move_Actions takes nothing returns nothing
        local unit u = GetTriggerUnit()
        if GetOwningPlayer(u)==udg_team1[0]  then
            call SetUnitAbilityLevel(u,'A0GU',9)
            call SetNextWayPoint(u)
        elseif GetOwningPlayer(u)==udg_team2[0]  then
            call SetUnitAbilityLevel(u,'A0GU',6)
            call SetNextWayPoint(u)
        endif
        set u = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set gg_trg_Lower_Line_Sound_Move = CreateTrigger(  )
        call TriggerRegisterEnterRectSimple( gg_trg_Lower_Line_Sound_Move, gg_rct_Path_Lower_Shinobi )
        call TriggerAddAction( gg_trg_Lower_Line_Sound_Move, function Trig_Lower_Line_Sound_Move_Actions )
    endfunction
endscope