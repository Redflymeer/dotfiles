FROM debian:bookworm-slim

# Ставим всё, что нужно для Java-игр (выполняется ТОЛЬКО при сборке)
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-17-jre  \
    libgl1 libglfw3 libopenal1 libxcursor1 libxcb-cursor0 fuse3 \
    x11-apps wget curl xterm \
    && rm -rf /var/lib/apt/lists/*

# Создаём пользователя внутри контейнера (флаг -U создаст группу с тем же именем)
RUN useradd -m -u 1000 -U user



# Переключаемся на пользователя
USER user
WORKDIR /home/user

# По умолчанию запускаем оболочку (а не AppImage)
CMD ["/bin/bash"]
