function setCharAt(oriStr, index, chr)
{
	return oriStr.substr(0, index) + chr + oriStr.substr(index + 1);
}

function applyMask(maskStr, currentValue)
{
    var result = String();
    result = "11111111";
    
    for (var i = 0; i < 8; i++)
    {
        if (maskStr.charAt(i) == '1')
        {
            result = setCharAt(result, i, maskStr.charAt(i + 8));
        }
        else
        {
            result = setCharAt(result, i, currentValue.charAt(i));
        }
    }
    
    return result;
}

function unapplyMask(maskStr, currentValue)
{
    var result = String();
    result = "11111111";
    
    for (var i = 0; i < 8; i++)
    {
        if (maskStr.charAt(i) == '1')
        {
            var newChr = '0';
            
            if (maskStr.charAt(i + 8) == '0')
            {
                newChr = '1';
            }
            
            result = setCharAt(result, i, newChr);
        }
        else
        {
            result = setCharAt(result, i, currentValue.charAt(i));
        }
    }
    
    return result;
}

function matchMask(maskStr, currentValue)
{
    var result = Boolean();
    result = true;
    
    for (var i = 0; i < 8; i++)
    {
        if (maskStr.charAt(i) == '1')
        {
            if (maskStr.charAt(i + 8) != currentValue.charAt(i))
            {
                result = false;
                break;
            }
        }
    }
    
    return result;
}

function hexStrToBinStr(hexStr)
{
    return ensureLength(parseInt(ensureLength(hexStr, 2), 16).toString(2), 8);
}

function binStrToHexStr(binStr)
{
    return ensureLength(parseInt(binStr, 2).toString(16), 2).toUpperCase();
}

function ensureLength(str, len)
{
    while (str.length < len)
    {
        str = '0' + str;
    }
    
    return str.toUpperCase();
}

function selectAll(eleID)
{
    var ele = document.getElementById(eleID);
    ele.focus();
    ele.select();
}