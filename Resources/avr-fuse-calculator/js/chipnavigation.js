function naviToChip(chipName)
{
    var listEle = document.getElementById("chip_nav_list");
    if (chipName == listEle.value)
    {
        return;
    }
    
    var newChipName = listEle.value;
    
    location.href = getPermalink(newChipName);
}