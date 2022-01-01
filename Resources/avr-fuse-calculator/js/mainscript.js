var allowBitCheckboxChangeEvent = true;
var allowPresetChangeEvent = true;

function applyDefaultClick(fuseName, defVal)    
{
    var hexStr = ensureLength(defVal.toString(16), 2).toUpperCase();
    document.getElementById("byte_" + fuseName + "_textbox").value = hexStr;
    applyFuseTextbox(fuseName);
}

function applyFuseTextbox(fuseName)
{
    var textBox = document.getElementById("byte_" + fuseName + "_textbox");
    var valSpan = document.getElementById("dudecmd_" + fuseName + "_val_span");
    
    if (validateHexStr(textBox.value) == false)
    {
        fuseTextboxBgColor(fuseName, false);
        
        return;
    }
    
    fuseTextboxBgColor(fuseName, true);
    var newTxtVal = ensureLength(textBox.value, 2);
    if (newTxtVal != textBox.value)
    {
        textBox.value = newTxtVal;
    }
    
    if (valSpan != null)
    {
        valSpan.innerHTML = textBox.value;
    }
    
    var binStr = hexStrToBinStr(textBox.value);
    
    allowBitCheckboxChangeEvent = false;
    
    for (var i = 0; i < 8; i++)
    {
        var chkBox = document.getElementById(fuseName + "_bit_" + i.toString(10));
        
        if (binStr.charAt(7 - i) == '1')
        {
            chkBox.checked = false;
        }
        else
        {
            chkBox.checked = true;
        }
    }
    
    allowBitCheckboxChangeEvent = true;
    allowPresetChangeEvent = false;
    
    for (var i = 0; i < 256; i++)
    {
        var chkBox = document.getElementById("preset_" + fuseName + "_" + i.toString(10) + "_checkbox");
        if (chkBox != null)
        {
            if (matchMask(chkBox.value, binStr) == true)
            {
                chkBox.checked = true;
            }
            else
            {
                chkBox.checked = false;
            }
        }
        else
        {
            var dropDown = document.getElementById("preset_" + fuseName + "_" + i.toString(10) + "_dropdown");
            if (dropDown == null)
            {
                break;
            }
            
            for (var j = 0; j < dropDown.length; j++)
            {
                if (matchMask(dropDown.options[j].value, binStr) == true)
                {
                    dropDown.selectedIndex = j;
                    break;
                }
            }
        }
    }
    
    allowPresetChangeEvent = true;
    
    //var hiddenEle = document.getElementById(fuseName).value = textBox.value;
    
    setPermalink();
}

function applyCheckboxPreset(fuseName, eleID, maskStr)
{
    if (allowPresetChangeEvent == false)
    {
        return;
    }
    
    var curValBinStr = checkBoxesToBinStr(fuseName);
    var chkBox = document.getElementById("preset_" + fuseName + "_" + eleID + "_checkbox");
    var newBinStr;
    
    if (chkBox.checked == true)
    {
        newBinStr = applyMask(maskStr, curValBinStr);
    }
    else
    {
        newBinStr = unapplyMask(maskStr, curValBinStr);
    }
    
    var hexStr = binStrToHexStr(newBinStr); 
    var textBox = document.getElementById("byte_" + fuseName + "_textbox");
    textBox.value = hexStr;
    applyFuseTextbox(fuseName);
}

function applyDropdownPreset(fuseName, eleID)
{
    if (allowPresetChangeEvent == false)
    {
        return;
    }
    
    var dropDown = document.getElementById("preset_" + fuseName + "_" + eleID + "_dropdown");
    var maskStr = dropDown.value;
    var curValBinStr = checkBoxesToBinStr(fuseName);
    var newBinStr = applyMask(maskStr, curValBinStr);
    var hexStr = binStrToHexStr(newBinStr);   
    var textBox = document.getElementById("byte_" + fuseName + "_textbox");   
    textBox.value = hexStr;
    applyFuseTextbox(fuseName);
}

function applyCheckboxBits(fuseName, bitNum)
{
    if (allowBitCheckboxChangeEvent == false)
    {
        return;
    }
    
    var textBox = document.getElementById("byte_" + fuseName + "_textbox");
        
    var binStr = checkBoxesToBinStr(fuseName);
    
    textBox.value = binStrToHexStr(binStr);
    
    applyFuseTextbox(fuseName);
}

function checkBoxesToBinStr(fuseName)
{
    var binStr = "";
    for (var i = 0; i < 8; i++)
    {
        var chkBox = document.getElementById(fuseName + "_bit_" + i.toString(10));
        
        if (chkBox.checked == false)
        {
            binStr = '1' + binStr;
        }
        else
        {
            binStr = '0' + binStr;
        }
    }
    
    return binStr;
}

function validateHexStr(str)
{
    var validChars = "1234567890abcdefABCDEF";
    for (var i = 0; i < str.length; i++)
    {
        if (validChars.indexOf(str.charAt(i)) < 0)
        {
            return false;
        }
    }
    
    return true;
}

function fuseTextboxBgColor(fuseName, isValid)
{
    var ele = document.getElementById("byte_" + fuseName + "_textbox");
    if (isValid == false)
    {
        ele.style.backgroundColor = "#FFCCCC";
    }
    else
    {
        ele.style.backgroundColor = "#FFFFFF";
    }
}

function getRequestStr()
{
    var res = String();
    res = "";
    
    for (var i = 0; i < 256; i++)
    {
        var tblCell = document.getElementById("byte_table_fuse_label_" + i.toString(10) + "_cell");
        if (tblCell == null)
        {
            break;
        }
        
        res = res + "&" + tblCell.innerHTML + "=" + binStrToHexStr(checkBoxesToBinStr(tblCell.innerHTML));
    }
    
    return res;
}

function setPermalink()
{
    document.getElementById("permalink_textbox").value = getPermalink(document.getElementById("chip_nav_list").value);
}

function getPermalink(chipName)
{
    var fileLoc = location.href;
    var dirLoc = fileLoc.substring(0, fileLoc.lastIndexOf('/') + 1);
    var newLoc = dirLoc + "fusecalc.php?chip=" + chipName + getRequestStr();
    return newLoc
}

function permaLinkClick()
{
    var ele = document.getElementById("permalink_textbox");
    
    setPermalink();
    
    ele.focus();
    ele.select();
}

function bodyLoad()
{
    try{applyURLValues();}catch(err){}
    setPermalink();
}