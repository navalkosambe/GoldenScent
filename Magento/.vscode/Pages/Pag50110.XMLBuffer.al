page 50110 XMLBuffer
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "XML Buffer";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Type; Type)
                {
                    ApplicationArea = All;

                }
                field(Name; Name)
                {
                    ApplicationArea = All;

                }
                field(Path; Path)
                {
                    ApplicationArea = All;

                }
                field(Value; Value)
                {
                    ApplicationArea = All;

                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}