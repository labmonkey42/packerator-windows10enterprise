# Create the virtual environment and activate it
$not_venv = & python -c "import sys; print (sys.base_prefix == sys.prefix)"
If ($not_venv -eq "True") {
    "Creating python virtual environment"
    & python -m venv $PSScriptRoot
    "Activating python virtual environment"
    . $PSScriptRoot/Scripts/Activate.ps1
}

# Upgrade pip in the venv to avoid warnings while installing other packages
python -m pip install --upgrade pip

# Install pylint in the venv so that other imported packages are recognized by it
python -m pip install --upgrade pylint

# Install project dependency packages
$dependencies = @(
    "../packerator",
    "../packeratorwindows",
    "../packeratorwindows10",
    "../packeratorwindows10enterprise"
)
$dependencies | ForEach-Object { python -m pip install -e $_ }

# Start VSCode
code $PSScriptRoot
