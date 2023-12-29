#!/usr/bin/env python3

########################
#  Metis Setup Script  #
########################

import os
import sys
import winreg
import _winapi

######## GLOBALS #########
MAINDIR = "z"
PROJECTDIR = "mts"
##########################

def main():
    FULLDIR = f"{MAINDIR}\\{PROJECTDIR}"
    print(f"""
  #######################################
  # Metis Development Environment Setup #
  #######################################

  This script will create your Metis dev environment for you.

  Before you run this, you should already have:
    - The Arma 3 Tools installed properly via Steam
    - A properly set up P-drive

  If you have not done those things yet, please abort this script in the next step and do so first.

  This script will create two hard links on your system, both pointing to your Metis project folder:
    [Arma 3 installation directory]\\{FULLDIR} => Metis project HEMTT dev build folder
    P:\\{FULLDIR}                              => Metis project HEMTT dev build folder""")
    print("\n")

    try:
        reg = winreg.ConnectRegistry(None, winreg.HKEY_LOCAL_MACHINE)
        key = winreg.OpenKey(reg, r"SOFTWARE\Wow6432Node\bohemia interactive\arma 3")
        armapath = winreg.EnumValue(key,1)[1]
    except:
        print("Failed to determine Arma 3 Path.")
        return 2

    if not os.path.exists("P:\\"):
        print("No P-drive detected.")
        return 3

    scriptpath = os.path.realpath(__file__)
    projectpath = os.path.dirname(os.path.dirname(scriptpath))
    devpath = os.path.join(projectpath, '.hemttout', 'dev')

    print("# Detected Paths:")
    print(f"  Arma path:            {armapath}")
    print(f"  Project path:         {projectpath}")
    print(f"  HEMTT dev build path: {devpath}")

    repl = input("\nAre these correct? (y/n): ")
    if repl.lower() != "y":
        return 4

    print("\n# Creating links ...")
    try:
        os.makedirs(devpath, exist_ok=True)

        if not os.path.exists(os.path.join("P:", MAINDIR, PROJECTDIR)):
            os.makedirs(os.path.join("P:", MAINDIR), exist_ok=True)
            _winapi.CreateJunction(devpath, os.path.join("P:", MAINDIR, PROJECTDIR))
        else:
            print("Link on P: already exists. Skipping it.")

        if not os.path.exists(os.path.join(armapath, MAINDIR, PROJECTDIR)):
            os.makedirs(os.path.join(armapath, MAINDIR), exist_ok=True)
            _winapi.CreateJunction(devpath, os.path.join(armapath, MAINDIR, PROJECTDIR))
        else:
            print("Link in Arma directory already exists. Skipping it.")
    except:
        print("Something went wrong during the link creation. Please finish the setup manually.")
        raise

    print("# Links created successfully.")

    return 0


if __name__ == "__main__":
    exitcode = main()

    if exitcode > 0:
        print("\nSomething went wrong during the setup. If these issues persist, please follow the instructions on the Metis wiki to perform the setup manually.")
    else:
        print("\nSetup successfully completed.")

    sys.exit(exitcode)
