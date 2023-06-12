' ********** Copyright 2019 Roku Corp.  All Rights Reserved. **********

function ShowEpisodePickerView(seasonContent as Object) as Object
    m.episodePicker = CreateObject("roSGNode", "CategoryListView")
    m.episodePicker.posterShape = "16x9"
    content = CreateObject("roSGNode", "ContentNode")
    content.AddFields({
        HandlerConfigCategoryList: {
            name: "SeasonsHandler"
            seasons: seasonContent
        }
    })
    m.episodePicker.content = content
    m.episodePicker.ObserveField("selectedItem", "OnEpisodeSelected")
    'this will trigger job to show this View
    m.top.ComponentController.CallFunc("show", {
        view: m.episodePicker
    })
    return m.episodePicker
end function

sub OnEpisodeSelected(event as Object)
    'show details view with selected episode content
    categoryList = event.GetRoSGNode()
    itemSelected = event.GetData()
    category = categoryList.content.GetChild(itemSelected[0])
    detailsView = ShowDetailsView(category, itemSelected[1], true)
    detailsView.ObserveField("wasClosed", "OnEpisodeDetailsWasClosed")
end sub

sub OnEpisodeDetailsWasClosed(event as Object)
    details = event.GetRoSGNode()
    m.episodePicker.jumpToItemInCategory = details.itemFocused
end sub
