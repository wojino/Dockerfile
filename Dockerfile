# Base image
FROM pytorch/pytorch:2.5.1-cuda12.4-cudnn9-devel

# Install basic tools and Python packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Jupyter and ipykernel
RUN pip install --no-cache-dir \
    notebook \
    ipykernel \
    numpy \
    pandas \
    scikit-learn \
    matplotlib

# Configure case-insensitive tab completion
RUN echo "set completion-ignore-case on" >> /etc/inputrc

# Create and register a Jupyter kernel
RUN python -m ipykernel install --user --name=container-python --display-name "Python (Docker)"

# Set working directory
WORKDIR /workspace

# Expose Jupyter port
EXPOSE 8888

# Start Bash
CMD ["/bin/bash"]
