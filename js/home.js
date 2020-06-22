function checkHome (homeForm)
{
    while (homeForm.username.value == "")
    {
        alert("Enter a username.")
        return false;
    }
}