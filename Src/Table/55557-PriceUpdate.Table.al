table 55557 "Price Update"
{

    fields
    {
        field(1; Item; Code[20])
        {
        }
        field(2; "Prod Disc"; Decimal)
        {
        }
        field(3; Updated; Boolean)
        {
        }
    }

    keys
    {
        key(Key1; Item)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

