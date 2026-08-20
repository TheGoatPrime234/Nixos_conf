import asyncio
from nio import AsyncClient, MatrixRoom, RoomMessageText
import subprocess
import sys

async def main():
    try:
        with open("/run/agenix/matrix-bot-token", "r") as f:
            token = f.read().strip()
    except FileNotFoundError:
        print("Fehler: Token-Datei nicht gefunden!")
        sys.exit(1)

    client = AsyncClient("https://matrix.deine-domain.de", "@opsbot:deine-domain.de")
    client.access_token = token
    ALLOWED_USER = "@cato:deine-domain.de"

    async def message_callback(room: MatrixRoom, event: RoomMessageText) -> None:
        if event.sender != ALLOWED_USER:
            return

        if event.body == "!start_lab":
            await client.room_send(
                room_id=room.room_id,
                message_type="m.room.message",
                content={"msgtype": "m.text", "body": "Start Metasploitable"}
            )
            subprocess.run(["/run/wrappers/bin/sudo", "/run/current-system/sw/bin/systemctl", "start", "podman-metasploitable.service"])
            await client.room_send(
                room_id=room.room_id,
                message_type="m.room.message",
                content={"msgtype": "m.text", "body": "🚀 Metasploitable gestartet! Viel Spaß beim Hacken unter 10.99.99.1."}
            )
            
        elif event.body == "!stop_lab":
            await client.room_send(
                room_id=room.room_id,
                message_type="m.room.message",
                content={"msgtype": "m.text", "body": "Stoppe Metasploitable"}
            )
            subprocess.run(["/run/wrappers/bin/sudo", "/run/current-system/sw/bin/systemctl", "stop", "podman-metasploitable.service"])
            await client.room_send(
                room_id=room.room_id,
                message_type="m.room.message",
                content={"msgtype": "m.text", "body": "🛑 Lab erfolgreich heruntergefahren."}
            )

        elif event.body == "test":
            await client.room_send(
                room_id=room.room_id,
                message_type="m.room.message",
                content={"msgtype": "m.text", "body": "Test erfolgreich"}
            )

    client.add_event_callback(message_callback, RoomMessageText)
    await client.sync_forever(timeout=30000)

asyncio.run(main())
