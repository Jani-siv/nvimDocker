# Use an official Ubuntu as a base image
FROM ubuntu:22.04

# Set environment variables to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install essential packages and tools
RUN apt-get update
RUN apt-get install -y build-essential    # Tools for building software (make, gcc, g++)
RUN apt-get install -y git                # Version control
RUN apt-get install -y curl               # Data transfer tool
RUN apt-get install -y cmake              # Build system
RUN apt-get install -y python3            # Python for scripting
RUN apt-get install -y python3-pip        # Python package manager
RUN apt-get install -y clangd             # Clangd for code completion
RUN apt-get clean     # Clean up package lists to reduce image size

# Install Node.js and npm via apt-get
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm -v && \
    node -v
    
#install all required language servers
RUN npm install -g pyright
RUN npm install -g bash-language-server

# Create a non-root user (optional but recommended for development)
RUN useradd -ms /bin/bash devuser
# Set the user to 'devuser'
USER devuser

# Set the working directory inside the container
WORKDIR /home/devuser/dev

# Install Neovim
WORKDIR /home/devuser/bin
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
RUN tar -xzf nvim-linux64.tar.gz
RUN echo "PATH=$PATH:/home/devuser/bin/nvim-linux64/bin" >> ~/.bashrc
# Clone latest nvim settings
RUN git clone https://github.com/Jani-siv/nvimSettings.git /home/devuser/.config/nvim
#RUN mkdir -p /home/devuser/.config/nvim
#RUN mkdir -p /home/devuser/.config/nvim/lua

# update nvim settings
#COPY nvimSettings/init.lua /home/devuser/.config/nvim/init.lua
#COPY nvimSettings/lua/lsp_config.lua /home/devuser/.config/nvim/lua/lsp_config.lua

# Junegunn Plugin installer for nvim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# Start bash by default
#CMD ["/bin/bash"]
CMD ["sleep", "infinity"]
