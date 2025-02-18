let admin = {
      username: 'admin',
      password: 'admin123',
      email: 'admin@railway.com',
      mobile: '9876543210'
    };

    let clients = JSON.parse(localStorage.getItem('clients')) || [];
    let trains = JSON.parse(localStorage.getItem('trains')) || [];

    // Show section function
    function showSection(sectionId) {
      document.querySelectorAll('.section').forEach(section => {
        section.classList.add('hidden');
      });
      document.getElementById(sectionId).classList.remove('hidden');
      if(sectionId === 'home') updateDashboard();
    }

    // Update Dashboard
    function updateDashboard() {
      // Update aggregate data
      document.getElementById('ticketsPerClass').textContent = 
        clients.reduce((acc, client) => acc + client.tickets, 0);
      
      // Update clients table
      const tbody = document.querySelector('#clientsTable tbody');
      tbody.innerHTML = '';
      clients.forEach(client => {
        const row = document.createElement('tr');
        row.innerHTML = `
          <td>${client.userId}</td>
          <td>${client.userName}</td>
          <td>${client.userMobile}</td>
          <td>${client.userTickets}</td>
          <td><button onclick="deleteClient('${client.id}')">Delete</button></td>
        `;
        tbody.appendChild(row);
      });
    }

    // Delete Client
    function deleteClient(clientId) {
      if(confirm('Are you sure you want to delete this client?')) {
        clients = clients.filter(client => client.id !== clientId);
        localStorage.setItem('clients', JSON.stringify(clients));
        updateDashboard();
      }
    }

    // Train Form Submission
    document.getElementById('trainForm').addEventListener('submit', e => {
      e.preventDefault();
      const newTrain = {
        id: `TRN${Date.now()}`,
        name: document.getElementById('trainName').value,
        seats: document.getElementById('seats').value,
        from: document.getElementById('from').value,
        to: document.getElementById('to').value,
        ownership: document.getElementById('ownership').value
      };
      trains.push(newTrain);
      localStorage.setItem('trains', JSON.stringify(trains));
      alert('Train registered successfully!');
      e.target.reset();
    });

    // Profile Form Submission
    document.getElementById('profileForm').addEventListener('submit', e => {
      e.preventDefault();
      admin.username = document.getElementById('username').value;
      admin.mobile = document.getElementById('mobile').value;
      admin.email = document.getElementById('email').value;
      
      const newPassword = document.getElementById('password').value;
      if(newPassword) admin.password = newPassword;
      
      alert('Profile updated successfully!');
    });

    // Logout
    function logout() {
      window.location.href = 'login.html';
    }

    // Initialize
    showSection('home');
    document.getElementById('username').value = admin.username;
    document.getElementById('mobile').value = admin.mobile;
    document.getElementById('email').value = admin.email;
