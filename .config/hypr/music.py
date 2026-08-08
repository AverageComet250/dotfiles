import dbus

# players = [name for name in dbus.SessionBus().list_names() if name.startswith("org.mpris.MediaPlayer2.")]
#
# if len(players) == 0:
#     exit()
# else:
#     player = dbus.Interface(dbus.SessionBus().get_object(players[0], '/org/mpris/MediaPlayer2'), 'org.freedesktop.DBus.Properties')
try:

    # player = [
    #     player
    #     for player in [
    #         dbus.Interface(
    #             dbus.SessionBus().get_object(name, "/org/mpris/MediaPlayer2"),
    #             "org.freedesktop.DBus.Properties",
    #         )
    #         for name in dbus.SessionBus().list_names()
    #         if name.startswith("org.mpris.MediaPlayer2.") and name.find("firefox") == -1
    #     ]
    #     if player.Get("org.mpris.MediaPlayer2.Player", "Metadata").get(
    #         "xesam:title", "Unknown"
    #     )
    #     != ""
    #     and ", ".join(
    #         player.Get("org.mpris.MediaPlayer2.Player", "Metadata").get(
    #             "xesam:artist", ["Unknown"]
    #         )
    #     )
    #     != ""
    # ]

    player = dbus.Interface(
        dbus.SessionBus().get_object(
            [
                name
                for name in dbus.SessionBus().list_names()
                if name.startswith("org.mpris.MediaPlayer2.")
                and name.find("firefox") == -1
            ][0],
            "/org/mpris/MediaPlayer2",
        ),
        "org.freedesktop.DBus.Properties",
    )

    playing = (
        "▶"
        if player.Get("org.mpris.MediaPlayer2.Player", "PlaybackStatus") == "Playing"
        else "⏸"
    )
    metadata = player.Get("org.mpris.MediaPlayer2.Player", "Metadata")
    player_name = str(player).split(".")[-1]
    track = metadata.get("xesam:title", "Unknown").lower()
    artists = ", ".join(metadata.get("xesam:artist", ["Unknown"])).lower()
    album = metadata.get("xesam:album", "Unknown").lower()

    if len(artists) == 0 or len(track) == 0:
        # print(metadata)
        # print(artists)
        # print(track)
        raise IndexError("missing artist or track")

    # print(f"{track} - {artists} ({album}) {playing}")
    # print(f"{track} - {artists}  {playing}")
    print(f"{track} — {artists}")
except Exception as e:
    # print("exception:", type(e))
    exit()
