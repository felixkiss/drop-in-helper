jQuery ->
	search_term = '';

	$('#search input').keyup ->
		if search_term != $(this).val() && $(this).val() != ''
			search_term = $(this).val()
			$.ajax({
				url: '/players/search/' + search_term + '.json',
			}).done (data) ->
				results = $('#results')
				results.html('')
				perfect_match = false
				$.each data, ->
					# console.log this.gamertag
					perfect_match = true if this.gamertag == search_term

					if this.rating == 'good'
						bad_class_name = ''
						good_class_name = 'active' 
					else if this.rating == 'bad'
						bad_class_name = 'active'
						good_class_name = '' 
					# results.append('<li>' + this.gamertag + '<div class="right"><a href="/players/' + this.id + '/bad" data-method="put" data-remote="true">-</a> <span class="rating ' + class_name + '">' + this.rating + '</span> <a href="/players/' + this.id + '/good" data-method="put" data-remote="true">+</a></div></li>')
					results.append(
						'<li id="item-' + this.id + '">' + this.gamertag + 
						'<div class="right rating btn-group">' +
							'<a class="btn bad ' + bad_class_name + '" href="/players/' + this.id + '/bad.js" data-method="put" data-remote="true">bad</a>' +
							'<a class="btn good ' + good_class_name + '" href="/players/' + this.id + '/good.js" data-method="put" data-remote="true">good</a>' +
						'</div></li>'
					)

				# results.append('<li>' + search_term + '<div class="right"><a href="">-</a> <span class="rating"></span> <a href="">+</a></div></li>') if !perfect_match
				results.append(
					'<li class="new_player">' + search_term + 
					'<div class="right rating btn-group">' +
						'<a class="btn bad" href="/players/' + search_term + '/bad.js" data-method="put" data-remote="true">bad</a>' +
						'<a class="btn good" href="/players/' + search_term + '/good.js" data-method="put" data-remote="true">good</a>' +
					'</div></li>'
				) if !perfect_match

	$('#search .clear_search').click ->
		$('#search input').val('')
		$('#search input').focus()

	$('#search input').focus()