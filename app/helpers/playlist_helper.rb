module PlaylistHelper
  # send playlist creation request
  def make_playlist user, list_name
    playlist = user.create_playlist!(list_name, public: true)
    db_playlist = Playlist.new(user_id: @current_user.id, name: playlist.name, spotify_uri: playlist.external_urls["spotify"], embed: playlist.uri)
    if db_playlist.save
      {playlist_object: playlist, db_object: db_playlist}
    end
  end

  # send add_tracks request with array of RSpotify Track objects as argument,
  # then build a Playlist object in db so we can return useful info to the user
  def add_songs tracklist, playlist_object
    playlist_object.add_tracks!(tracklist)
  end
end
