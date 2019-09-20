// Copyright 1998-2019 Epic Games, Inc. All Rights Reserved.

using UnrealBuildTool;
using System.Collections.Generic;

public class UE4DedicatedServerServerTarget : TargetRules
{
    public UE4DedicatedServerServerTarget(TargetInfo Target) : base(Target)
    {
        Type = TargetType.Server;
        ExtraModuleNames.Add("UE4DedicatedServer");
        bUseLoggingInShipping = true;

        // NOTE - this will throw a linking error unless using our patched
        // version of UE4 which implements main()
        bIsBuildingConsoleApplication = true;
    }
}
