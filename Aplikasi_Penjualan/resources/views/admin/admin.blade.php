@extends('adminlte::page')

@section('title', 'Dashboard')

@section('content_header')
    <h1>Admin</h1>
@stop

@section('content')
<main class="main">
    <ol class="breadcrumb">
        <li class="breadcrumb-item">Home</li>
        <li class="breadcrumb-item active">Admin</li>
    </ol>
    <div class="container-fluid">
        <div class="animated fadeIn">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">
                                Data Admin
                            </h4>
                        </div>
                        <div class="card-body">
                            @if (session('success'))
                                <div class="alert alert-success">{{ session('success') }}</div>
                            @endif

                            @if (session('error'))
                                <div class="alert alert-danger">{{ session('error') }}</div>
                            @endif

                            <!-- <form action="{{ route('report.order') }}" method="get">
                                <div class="input-group mb-3 col-md-4 float-right">
                                    <input type="text" id="created_at" name="date" class="form-control">
                                    <div class="input-group-append">
                                        <button class="btn btn-secondary" type="submit">Filter</button>
                                    </div>
                                    <a target="_blank" class="btn btn-primary ml-2" id="exportpdf">Export PDF</a>
                                </div>
                            </form> -->
                            <div class="table-responsive">
                                <table class="table table-hover table-bordered">
                                    <thead>
                                        <tr>
                                            <th>id</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>level</th>
                                            <th>Foto admin</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        @forelse ($user as $row)
                                        <tr>
                                            <td><strong>{{ $row->id }}</strong></td>
                                            <td>
                                                <strong>{{ $row->name }}</strong><br>

                                               
                                                
                                            </td>
                                            <td>{{ $row->email }}</td>
                                            <td>{{ $row->level }}</td>
                                            <td>{{ $row->profile_photo_path }}</td>
                                        </tr>
                                        @empty
                                        <tr>
                                            <td colspan="6" class="text-center">Tidak ada data</td>
                                        </tr>
                                        @endforelse
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
@endsection

<!-- @section('js')
    <script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    <script>
        $(document).ready(function() {
            let start = moment().startOf('month')
            let end = moment().endOf('month')

            $('#exportpdf').attr('href', 'order/pdf/' + start.format('YYYY-MM-DD') + '+' + end.format('YYYY-MM-DD'))

            $('#created_at').daterangepicker({
                startDate: start,
                endDate: end
            }, function(first, last) {
                $('#exportpdf').attr('href', 'order/pdf/' + first.format('YYYY-MM-DD') + '+' + last.format('YYYY-MM-DD'))
            })
        })
    </script>
@endsection() -->
