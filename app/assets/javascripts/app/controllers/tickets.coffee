$ = jQuery

class TicketsListItem extends Spine.Controller
  tag: 'li'

  elements:
    '.advance': 'advance',
    '.reverse': 'reverse'

  constructor: ->
    super
    @render()

  render: =>
    console.log(@item)
    console.log($.tmpl('app/views/tickets/list_item', @item))
    @html $.tmpl('app/views/tickets/list_item', @item)

class TicketsList extends Spine.Controller
  elements:
    '.fridge': 'fridge',
    '.development': 'development',
    '.peer_review': 'peer_review',
    '.user_acceptance': 'user_acceptance',
    '.archived': 'archived'
  
  constructor: ->
    super
    Ticket.bind('refresh change', @render)
    
  render: =>
    fridge_tickets = Ticket.findAllByAttribute('state', 'fridge')
    fridge_tickets.map (ticket) =>
      @fridge.append('foo')
      @fridge.append(new TicketsListItem(item: ticket))
      @fridge.append('bar')
    #@fridge.html $.tmpl('app/views/tickets/list', Ticket.findAllByAttribute('state', 'fridge'))
    #@development.html $.tmpl('app/views/tickets/list', Ticket.findAllByAttribute('state', 'development'))
    #@peer_review.html $.tmpl('app/views/tickets/list', Ticket.findAllByAttribute('state', 'peer_review'))
    #@user_acceptance.html $.tmpl('app/views/tickets/list', Ticket.findAllByAttribute('state', 'user_acceptance'))
    #@archived.html $.tmpl('app/views/tickets/list', Ticket.findAllByAttribute('state', 'archived'))
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/projects', @project_id, 'tickets', item.id

class Tickets extends Spine.Controller
  elements:
    '.lanes': 'lanes'

  constructor: ->
    super
    @list = new TicketsList(el: @lanes, project_id: @project_id)
    
    new Spine.Manager(@list)
    
    @routes
      '/projects/:project_id/tickets': (params) ->
        @list.active(params)

    @navigate '/projects', @project_id, 'tickets'
        
    # Only setup routes once tickets have loaded
    Ticket.bind 'refresh', ->
      Spine.Route.setup()

    Ticket.fetch({ project_id: @project_id })
  
window.Tickets = Tickets